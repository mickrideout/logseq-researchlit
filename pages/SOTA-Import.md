-
- **AIM** - to create SOTA boards based on PWC data
- **Datasets** - https://huggingface.co/pwc-archive
	- datasets.json
	-
- ## Data Examples
	- ### Datasets Example
	  collapsed:: true
		- ```json
		  [  
		    {
		      "url": "https://paperswithcode.com/dataset/jft-300m",
		      "name": "JFT-300M",
		      "full_name": "JFT-300M",
		      "homepage": "",
		      "description": "**JFT-300M** is an internal Google dataset used for training image classification models. Images are labeled using an algorithm that uses complex mixture of raw web signals, connections between web-pages and user feedback. This results in over one billion labels for the 300M images (a single image can have multiple labels). Of the billion image labels, approximately 375M are selected via an algorithm that aims to maximize label precision of selected images.",
		      "short_description": "JFT-300M is an internal Google dataset used for training image classification models. Images are labeled using an algorithm that uses complex mixture of raw web signals, connections between web-pages and user feedback. This results in over one billion labels for the 300M images (a single image can have multiple labels). Of the billion image labels, approximately 375M are selected via an algorithm that aims to maximize label precision of selected images.",
		      "parent_dataset": null,
		      "image": "https://production-media.paperswithcode.com/datasets/Screen_Shot_2021-02-14_at_5.06.38_PM.png",
		      "audio": null,
		      "thumbnail": "https://production-media.paperswithcode.com/thumbnails/dataset/dataset-0000000003-b4e2f013_DyJWymg.jpg",
		      "default_image": null,
		      "verified_image": "https://production-media.paperswithcode.com/thumbnails/dataset-small/dataset-0000000003-4b92f30e.jpg",
		      "default_youtube_link": null,
		      "paper": {
		        "title": "Revisiting Unreasonable Effectiveness of Data in Deep Learning Era",
		        "url": "https://paperswithcode.com/paper/revisiting-unreasonable-effectiveness-of-data"
		      },
		      "mention_count": 0,
		      "introduced_date": "2017-07-10",
		      "license_name": "Private (not publicly available)",
		      "license_url": null,
		      "verified_name": "JFT-300M",
		      "verified_paper": {
		        "title": "Revisiting Unreasonable Effectiveness of Data in Deep Learning Era",
		        "url": "https://paperswithcode.com/paper/revisiting-unreasonable-effectiveness-of-data"
		      },
		      "warning": null,
		      "modalities": [
		        "Images"
		      ],
		      "tasks": [
		        {
		          "task": "Image Classification",
		          "url": "https://paperswithcode.com/task/image-classification"
		        }
		      ],
		      "languages": [
		        "Chinese"
		      ],
		      "variants": [
		        "JFT-300M"
		      ],
		      "num_papers": 123,
		      "data_loaders": [
		        {
		          "url": "https://github.com/tensorflow/models",
		          "repo": "https://github.com/tensorflow/models",
		          "frameworks": [
		            "tf",
		            "pytorch"
		          ]
		        }
		      ]
		    },
		  ]
		  ```
	-
- ### AI Review
	- ### Claude Review
		- I'll fetch the Papers with Code archive on Hugging Face to examine how their datasets are structured.Let me examine the key datasets to understand their structure. I'll start with the evaluation-tables dataset, which likely contains the SOTA benchmarks:Based on the Papers with Code archive on Hugging Face and the GitHub documentation, here's how the datasets link together to form SOTA benchmarks:
		- ## Core Dataset Structure
		  
		  The Papers with Code data consists of **6 interconnected datasets** that form a comprehensive knowledge graph:
		- ### 1.  **papers-with-abstracts**  (576k papers)
		  
		  Contains all academic papers with:
		- Paper titles
		- Abstracts
		- ArXiv IDs or URLs
		- Publication dates
		- ### 2.  **links-between-paper-and-code**  (300k links)
		  
		  Links papers to their implementations:
		- Paper ID → GitHub repository URL
		- Links papers to multiple code repositories
		- Tracks official vs community implementations
		- ### 3.  **datasets**  (15k datasets)
		  
		  Benchmark datasets information:
		- Dataset name and description
		- Subdatasets (e.g., ImageNet subsets)
		- Dataset links (download URLs)
		- Dataset citations
		- Related tasks
		- ### 4.  **methods**  (8.73k methods)
		  
		  Machine learning methods/models:
		- Method names (e.g., "ResNet-50", "BERT")
		- Method descriptions
		- Associated papers
		- Implementation links
		- ### 5.  **evaluation-tables**  (2.25k tables, 1.68k rows)
		  
		  **This is the core SOTA data** with the hierarchical structure:
		  
		  ```
		  Task
		  └─ Dataset
		      └─ Sota Table
		          ├─ Metrics (e.g., "Top-1 Accuracy", "F1 Score")
		          └─ SotaRows[]
		              ├─ Model name
		              ├─ Paper (title, URL, date)
		              ├─ Metric values {metric_name: score}
		              ├─ Code links
		              └─ Model links (pretrained weights)
		  ```
		- ### 6.  **files**  (158 items)
		  
		  Supporting files and additional data
		- ## How They Link Together
		  
		  The linkage follows this pattern:
		  
		  ```
		  ┌─────────────────┐
		  │     PAPERS      │◄─────┐
		  │  (papers-with-  │      │
		  │   abstracts)    │      │
		  └────────┬────────┘      │
		         │               │
		         │ paper_url     │ paper_title/url
		         │               │
		         ▼               │
		  ┌─────────────────┐      │
		  │   CODE REPOS    │      │
		  │ (links-between- │      │
		  │ paper-and-code) │      │
		  └─────────────────┘      │
		                         │
		  ┌─────────────────┐      │
		  │    METHODS      │──────┘
		  │   (methods)     │
		  └────────┬────────┘
		         │
		         │ methodology
		         │
		         ▼
		  ┌─────────────────────────────────┐
		  │     EVALUATION TABLES           │
		  │    (evaluation-tables)          │
		  │                                 │
		  │  Task                           │
		  │    ├─ Task Name                 │
		  │    └─ Datasets[]                │
		  │         ├─ Dataset Name ────────┼──► DATASETS
		  │         └─ Sota                 │    (datasets)
		  │              ├─ Metrics[]       │
		  │              └─ Rows[]          │
		  │                  ├─ model_name ─┼──► METHODS
		  │                  ├─ paper ──────┼──► PAPERS
		  │                  ├─ metrics{}   │
		  │                  └─ code_links ─┼──► CODE REPOS
		  └─────────────────────────────────┘
		  ```
		- ## Practical Example: Image Classification on ImageNet
		  
		  Here's how a SOTA benchmark is constructed:
		- **Task**: "Image Classification"
		- **Dataset**: "ImageNet" (from `datasets`)
		- **Evaluation Table** contains:
			- **Metrics**: ["Top-1 Accuracy", "Top-5 Accuracy"]
			- **SOTA Rows**:
			  
			  ```
			  {  "model_name": "ResNet-50",  "paper_title": "Deep Residual Learning...",  "paper_url": "arxiv.org/abs/1512.03385",  "paper_date": "2015-12-10",  "metrics": {    "Top-1 Accuracy": "76.15",    "Top-5 Accuracy": "92.87"  },  "code_links": [    {"title": "Official", "url": "github.com/..."}  ]}
			  ```
		- **Method** "ResNet-50" links to:
			- The paper in `papers-with-abstracts`
			- Implementation in `links-between-paper-and-code`
		- ## Key Foreign Keys
		  
		  The relationships use these identifiers:
		- **paper_url** or **paper_title**: Links SOTA rows → papers
		- **model_name/methodology**: Links SOTA rows → methods
		- **dataset** name: Links SOTA tables → datasets
		- **code_links**: Links SOTA rows → code repositories
		- ## For Your ResearchLit Project
		  
		  This structure is particularly valuable because:
		- **Hierarchical organization**: Tasks → Datasets → Benchmarks makes navigation intuitive
		- **Rich metadata**: Each SOTA row contains paper, code, metrics, and dates
		- **Reproducibility**: Direct links to code implementations
		- **Time-series data**: Paper dates allow tracking SOTA progression over time
		- **Multi-metric evaluation**: Each benchmark can have multiple evaluation metrics
		  
		  The `evaluation-tables` dataset is the centerpiece that ties everything together into actionable benchmark information.
		- I'll search for more information about how Papers with Code generated their full dataset beyond the sota-extractor scrapers.Based on my research, here's how the Papers with Code datasets were produced beyond the sota-extractor scrapers:
		- ## Data Sources & Collection Methods
		- ### 1.  **Community Contributions (Primary Source)**
		  
		  Papers with Code was fundamentally **community-driven** - users could contribute through:
		- **Edit buttons** on every page to add/modify content
		- **API submissions** for programmatic data contribution
		- User-submitted papers, code links, benchmark results, and dataset information
		- All content licensed under CC-BY-SA, encouraging open collaboration
		- ### 2.  **ArXiv Integration**
		- **Automated scraping** of ArXiv metadata (papers, abstracts, authors, dates)
		- Daily updates to capture new papers
		- Used ArXiv API to fetch paper information
		- The `papers-with-abstracts` dataset (576k papers) likely came from continuous ArXiv monitoring
		- ### 3.  **GitHub API Integration**
		- **Automated discovery** of code repositories mentioned in papers
		- The `links-between-paper-and-code` dataset (300k links) was built by:
			- Parsing paper text for GitHub URLs
			- GitHub API queries to validate repositories
			- Community submissions via the API or web interface
			- Detection of README files mentioning paper citations
		- ### 4.  **API-based Benchmark Submissions**
		  
		  From the `paperswithcode-client` repository, they provided an **API for competition/benchmark synchronization**:
		  
		  ```
		  # Users could programmatically submit benchmark results
		  EvaluationTableSyncRequest(
		    task="Image Classification",
		    dataset="ImageNet",
		    metrics=[...],
		    results=[
		        ResultSyncRequest(
		            metrics={"Top 1 Accuracy": "85"},
		            paper="https://arxiv.org/abs/...",
		            methodology="ResNet-50"
		        )
		    ]
		  )
		  ```
		  
		  This allowed:
		- Research groups to mirror their competition leaderboards
		- Automated submission from ML platforms
		- Bulk uploads of benchmark results
		- ### 5.  **Scraped Benchmark Tables (sota-extractor)**
		  
		  The sota-extractor repo scraped from:
		- **NLP-progress** (hand-annotated SOTA results)
		- **EFF** (curated benchmarks)
		- **SQuAD** (active leaderboard)
		- **RedditSota** (community-curated results)
		- **SNLI, Cityscapes** (specific benchmark websites)
		- ### 6.  **Manual Curation**
		- **Methods dataset** (8.73k methods): Likely curated from papers, with structured metadata about techniques
		- **Datasets dataset** (15k datasets): Required manual organization of:
			- Dataset taxonomies
			- Subdatasets and partitions
			- Task associations
			- Citation information
		- ## Data Generation Pipeline
		  
		  Based on the evidence, the overall pipeline was:
		  
		  ```
		  ┌─────────────────────────────────────────────────────┐
		  │                  DATA INGESTION                      │
		  ├─────────────────────────────────────────────────────┤
		  │ 1. ArXiv Daily Scraper → papers-with-abstracts      │
		  │ 2. GitHub API Monitor → links-between-paper-and-code│
		  │ 3. Community Edits → All datasets                   │
		  │ 4. API Submissions → evaluation-tables               │
		  │ 5. Benchmark Scrapers → evaluation-tables            │
		  │ 6. Manual Curation → methods, datasets               │
		  └─────────────────────────────────────────────────────┘
		                         ↓
		  ┌─────────────────────────────────────────────────────┐
		  │              DATA PROCESSING & LINKING               │
		  ├─────────────────────────────────────────────────────┤
		  │ • Deduplicate papers/methods                        │
		  │ • Link papers ↔ code repositories                   │
		  │ • Associate benchmarks with datasets/tasks          │
		  │ • Validate metric names and values                  │
		  │ • Build hierarchical task taxonomy                  │
		  └─────────────────────────────────────────────────────┘
		                         ↓
		  ┌─────────────────────────────────────────────────────┐
		  │               DAILY REGENERATION                     │
		  ├─────────────────────────────────────────────────────┤
		  │ • Export to JSON files (paperswithcode-data)        │
		  │ • Publish to Hugging Face (pwc-archive)             │
		  │ • Update website database                           │
		  └─────────────────────────────────────────────────────┘
		  ```
		- ## Key Insights for ResearchLit
		  
		  The remaining datasets that weren't from sota-extractor were produced through:
		- **Hybrid approach**: Combining automated scraping with community contributions
		- **API-first**: Allowing programmatic submissions encouraged ecosystem integration
		- **Wikipedia model**: Anyone could edit/contribute under CC-BY-SA license
		- **Platform integrations**: Hugging Face, GitHub, ArXiv APIs working together
		- **Meta ownership**: Run by Meta AI but community-maintained
		- **Daily regeneration**: Continuous updates kept data fresh
		  
		  The sota-extractor was just the **seed data** - the real growth came from the community-driven model where thousands of researchers contributed paper-code links, benchmark results, and dataset information through both the web interface and API.