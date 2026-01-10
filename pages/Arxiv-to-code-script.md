-
- ### Task
	- A script that retrieves arXiv papers for a given date/date range, searches for associated code repositories, and stores both the papers and repository information in the database
- # Requirements
	- ### 1. ArXiv Paper Retrieval
		- #### 1.1 ArXiv API Integration
			- **Requirement**: Implement arXiv API integration to fetch papers by date
			- **Details**:
				- Use arXiv API (`http://export.arxiv.org/api/query`) to fetch papers
				- Support date-based queries (single date, date range, or month)
				- Parse arXiv API response (Atom XML format)
				- Extract basic metadata:
					- `arxiv_id` (e.g., "2401.12345" or "2401.12345v1")
					- `title`
					- `abstract`
					- `authors` (list of author names)
					- `year` (extracted from published date)
					- `published_date` (publication date)
					- `updated_date` (last update date)
					- `categories` (arXiv categories, e.g., cs.AI, cs.LG)
					- `url` (arXiv paper URL)
				- Handle API rate limiting and retries
				- Handle pagination for large result sets (arXiv API returns max 2000 results per query)
			- #### 1.2 Date Query Options
				- **Single Date**:
					- Format: `YYYY-MM-DD`
					- Retrieve all papers published on that specific date
					- Query parameter: `submittedDate:[YYYYMMDD TO YYYYMMDD]`
				- **Date Range**:
					- Format: `YYYY-MM-DD` to `YYYY-MM-DD`
					- Retrieve all papers published within the range (inclusive)
					- Query parameter: `submittedDate:[YYYYMMDD TO YYYYMMDD]`
				- **Month**:
					- Format: `YYYY-MM` or `YYYYMM`
					- Retrieve all papers published in that month
					- Automatically calculate first and last day of month
					- Query parameter: `submittedDate:[YYYYMM01 TO YYYYMMDD]`
	- #### 1.3 ArXiv API Service/Module
	- **Requirement**: Create reusable arXiv API service module
	- **Location**: `apps/api/app/services/arxiv_service.py`
	- **Features**:
		- Async HTTP client for arXiv API calls
		- XML parsing (Atom feed format)
		- Date range formatting and validation
		- Rate limiting handling (3 requests per second recommended)
		- Retry logic with exponential backoff
		- Error handling for API failures
	- ### 2. Code Repository Search
	- #### 2.1 Reuse Existing Code Repository Search Service
	- **Requirement**: Integrate with existing `CodeRepositorySearchService`
	- **Location**: `apps/api/app/services/code_repository_search.py`
	- **Details**:
		- Use `CodeRepositorySearchService.search_and_validate_repositories(paper_title)`
		- Returns list of validated `RepositoryMetadata` objects
		- Already includes:
			- GitHub repository search via Google Custom Search
			- Repository validation (size, language, README paper mention)
			- Confidence scoring
			- Metadata extraction (stars, forks, language, topics, etc.)
	- #### 2.2 Repository Search Strategy
	- For each paper:
	  
	  1. Search for repositories using paper title
	  
	  2. Validate repositories (filter by relevance, size, language)
	  
	  3. Store repository metadata if found (top repository or top N repositories)
	  
	  4. Store repository URL(s) in paper attributes
	- #### 2.3 Repository Storage Format
	- **Requirement**: Store repository information in paper `attributes` field
	- **Structure**:
	  
	  ```json
	  
	  {
	  
	    "extractions": {
	  
	      "code_repository": "https://github.com/owner/repo",
	  
	      "code_repository_found": true,
	  
	      "code_repository_stars": 1234,
	  
	      "code_repository_metadata": {
	  
	        "owner": "owner",
	  
	        "name": "repo",
	  
	        "full_name": "owner/repo",
	  
	        "url": "https://github.com/owner/repo",
	  
	        "description": "...",
	  
	        "stars": 1234,
	  
	        "forks": 56,
	  
	        "language": "Python",
	  
	        "topics": ["machine-learning", "pytorch"],
	  
	        "confidence_score": 0.95
	  
	      }
	  
	    }
	  
	  }
	  
	  ```
	- If multiple repositories found, store top repository (highest confidence score, then stars)
	- Option: Store multiple repositories as array if needed
	- ### 3. Paper Creation and Database Storage
	- #### 3.1 Paper Creation
	- **Requirement**: Create papers using existing `PaperService`
	- **Method**: Create new method `create_paper_from_arxiv_data()` similar to `create_paper_from_pwc_data()`
	- **Location**: `apps/api/app/services/paper_service.py`
	- **Details**:
		- Accept arXiv API response data
		- Create `Paper` instance with:
			- `title`: from arXiv entry
			- `authors`: list of author names
			- `year`: extracted from published_date
			- `arxiv_id`: cleaned arXiv ID (remove version suffix if storing base ID)
			- `url`: arXiv paper URL
			- `status`: `ProcessingStatus.DONE` (since we only have metadata)
			- `text_extraction`: `{"title": title, "abstract": abstract}`
			- `attributes`: repository information if found
	- #### 3.2 Duplicate Detection
	- **Requirement**: Check for existing papers before creating
	- **Strategy**: 
	  
	  1. Check by `arxiv_id` (exact match)
	  
	  2. If not found, check by title similarity (fuzzy match)
	  
	  3. If duplicate found:
		- Skip creation OR
		- Update existing paper with repository info if not already present
		- Log duplicate detection
	- #### 3.3 Batch Processing
	- **Requirement**: Process papers in batches for efficiency
	- **Details**:
		- Commit database transactions in batches (e.g., every 50-100 papers)
		- Handle errors gracefully (log and continue)
		- Track statistics: created, updated, skipped, errors
	- ### 4. Script Interface and Execution
	- #### 4.1 Command-Line Arguments
	- **Single Date**:
	  
	  ```bash
	  
	  python scripts/arxiv_paper_repo_search.py --date 2024-01-15 --env dev
	  
	  ```
	- **Date Range**:
	  
	  ```bash
	  
	  python scripts/arxiv_paper_repo_search.py --start-date 2024-01-01 --end-date 2024-01-31 --env dev
	  
	  ```
	- **Month**:
	  
	  ```bash
	  
	  python scripts/arxiv_paper_repo_search.py --month 2024-01 --env dev
	  
	  # OR
	  
	  python scripts/arxiv_paper_repo_search.py --month 202401 --env dev
	  
	  ```
	- #### 4.2 Optional Arguments
	- `--env` (required): Environment (`dev` or `prod`)
	- `--dry-run`: Preview what would be processed without database writes
	- `--skip-repo-search`: Only fetch papers, skip repository search
	- `--limit`: Limit number of papers to process (useful for testing)
	- `--batch-size`: Number of papers to commit per batch (default: 50)
	- `--max-repos-per-paper`: Maximum repositories to store per paper (default: 1)
	- `--verbose`: Enable verbose logging
	- #### 4.3 Script Structure
	- **Location**: `scripts/arxiv_paper_repo_search.py`
	- **Pattern**: Follow existing script patterns (e.g., `import_pwc_paper_abstracts.py`)
	- **Components**:
	  
	  1. Environment setup (load .env files)
	  
	  2. Database schema validation
	  
	  3. ArXiv API service initialization
	  
	  4. Code repository search service initialization
	  
	  5. Date range calculation
	  
	  6. Main processing loop:
		- Fetch papers from arXiv
		- For each paper:
			- Check for duplicates
			- Search for repositories (if enabled)
			- Create/update paper in database
		- Commit batches
		  
		  7. Statistics reporting
	- ### 5. Error Handling and Resilience
	- #### 5.1 ArXiv API Errors
	- Handle rate limiting (429 errors)
	- Implement exponential backoff retry
	- Handle malformed XML responses
	- Log API failures and continue with next paper
	- Track API call failures in statistics
	- #### 5.2 Repository Search Errors
	- Handle API failures (Google Custom Search, GitHub API)
	- Continue processing if repository search fails for a paper
	- Log errors but don't fail entire script
	- Track repository search failures
	- #### 5.3 Database Errors
	- Handle duplicate key errors gracefully
	- Rollback batch on critical errors
	- Log database errors with context
	- Continue processing remaining papers
	- ### 6. Logging and Reporting
	- #### 6.1 Progress Logging
	- Log each paper processed with status:
		- `Fetched`: Retrieved from arXiv
		- `Created`: New paper created
		- `Skipped`: Duplicate found
		- `Updated`: Existing paper updated with repo
		- `Error`: Processing failed
	- Progress indicators: `[X/Total]` format
	- Batch commit notifications
	- #### 6.2 Final Statistics
	- Total papers fetched from arXiv
	- Papers created
	- Papers skipped (duplicates)
	- Papers updated
	- Repository searches performed
	- Repositories found
	- Errors encountered
	- Processing time
	- #### 6.3 Log Levels
	- `INFO`: General progress and statistics
	- `DEBUG`: Detailed API calls and responses
	- `WARNING`: Non-fatal errors (continue processing)
	- `ERROR`: Fatal errors (may stop processing)
	- ### 7. Configuration and Dependencies
	- #### 7.1 Environment Variables
	- Reuse existing environment variables:
		- `WEB_SEARCH_API_KEY`: Google Custom Search API key
		- `WEB_SEARCH_ENGINE_ID`: Google Custom Search Engine ID
		- `GITHUB_API_TOKEN`: GitHub API token
		- Database connection variables (POSTGRES_*)
	- #### 7.2 Dependencies
	- Existing dependencies (already in project):
		- `aiohttp`: Async HTTP client
		- `sqlalchemy`: Database ORM
		- Existing service modules
	- New dependencies (if needed):
		- `feedparser` or `xml.etree.ElementTree`: For parsing arXiv Atom feed
		- Or use `aiohttp` + manual XML parsing
	- #### 7.3 Configuration Options
	- ArXiv API base URL: `http://export.arxiv.org/api/query`
	- Default max results per query: 2000 (arXiv API limit)
	- Default rate limit: 3 requests per second (respect arXiv API limits)
	- Default batch size: 50 papers
	- Default timeout: 30 seconds per API call
	- ### 8. Performance Considerations
	- #### 8.1 Async Processing
	- Use async/await for:
		- ArXiv API calls
		- Repository search operations
		- Database operations
	- Process papers concurrently where possible (with rate limiting)
	- #### 8.2 Rate Limiting
	- ArXiv API: 3 requests per second max
	- Google Custom Search: Respect existing service rate limits
	- GitHub API: Respect existing service rate limits
	- Add delays between API calls to avoid rate limits
	- #### 8.3 Batching
	- Process papers in batches for memory efficiency
	- Commit database transactions in batches
	- Stream large arXiv result sets if needed
	- ### 9. Testing and Validation
	- #### 9.1 Unit Tests
	- Test arXiv API date query formatting
	- Test XML parsing of arXiv responses
	- Test duplicate detection logic
	- Test repository storage format
	- #### 9.2 Integration Tests
	- Test end-to-end flow with small date range
	- Test error handling and recovery
	- Test batch processing
	- Test statistics reporting
	- #### 9.3 Validation
	- Validate date formats
	- Validate arXiv ID formats
	- Validate repository URLs before storage
	- Verify database schema compatibility
	- ### 10. Future Enhancements (Out of Scope but Noted)
	- Parallel processing of repository searches (with rate limiting)
	- Caching of repository search results
	- Support for arXiv categories filtering
	- Support for author filtering
	- Incremental updates (only fetch new papers)
	- Scheduling support (run daily/weekly automatically)
	- Export results to CSV/JSON
	- Webhook notifications on completion
	- ## Implementation Notes
	- ### Reusable Components
	  
	  1. **ArXiv API Service**: New service module (`apps/api/app/services/arxiv_service.py`)
	  
	  2. **Code Repository Search**: Existing service (already implemented)
	  
	  3. **Paper Service**: Extend with `create_paper_from_arxiv_data()` method
	  
	  4. **Database Models**: Reuse existing `Paper` model
	- ### Script Flow
	  
	  ```
	  
	  1. Parse command-line arguments
	  
	  2. Load environment variables
	  
	  3. Validate database schema
	  
	  4. Initialize services (ArXiv, Repository Search, Paper)
	  
	  5. Calculate date range from arguments
	  
	  6. Fetch papers from arXiv API
	  
	  7. For each paper:
	  
	   a. Check for duplicates
	  
	   b. If new: Search for repositories
	  
	   c. Create/update paper with repository info
	  
	   d. Batch commit
	  
	  8. Report statistics
	  
	  ```
	- ### Example Usage
	  
	  ```bash
	  
	  *# Process single date*
	  
	  python scripts/arxiv_paper_repo_search.py --date 2024-01-15 --env dev
	  
	  *# Process date range*
	  
	  python scripts/arxiv_paper_repo_search.py --start-date 2024-01-01 --end-date 2024-01-31 --env dev
	  
	  *# Process entire month*
	  
	  python scripts/arxiv_paper_repo_search.py --month 2024-01 --env dev
	  
	  *# Dry run (test without database writes)*
	  
	  python scripts/arxiv_paper_repo_search.py --date 2024-01-15 --env dev --dry-run
	  
	  *# Limit processing (testing)*
	  
	  python scripts/arxiv_paper_repo_search.py --month 2024-01 --env dev --limit 10
	  
	  ```