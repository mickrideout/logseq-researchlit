-
- **Task** - To import papers from hugging face into researchlit
- ## Requirements
	- Creat a new scripts - scripts/hugging-face-import.py
	- Command line parameters are:
		- --env (dev/prod)
		- --import-dir <dir-to-process>
	- For every json file in the import-dir with a name like '2024-11-10.json' do the following:
		- Read the json file (a sample of the file is in the section 'Example data')
		- For each paper in the 'papers' attribute:
			- if there is a 'pdf-file-location' submit the pdf for importing via the researchlit api
			- after the pdf file has been processed, update the
- ## Example Data
	- ```json
	  {
	    "date": "2023-05-04",
	    "papers": [
	      {
	        "title": "Personalize Segment Anything Model with One Shot",
	        "url": "https://huggingface.co/papers/2305.03048",
	        "authors": [
	          "Ziyu Guo",
	          "Shilin Yan",
	          "Junting Pan",
	          "Hao Dong",
	          "Peng Gao"
	        ],
	        "pdf_url": "https://arxiv.org/pdf/2305.03048.pdf",
	        "abstract": "",
	        "upvotes": 9,
	        "pdf-file-location": "papers/2023-05-04/Personalize_Segment_Anything_Model_with.pdf"
	      },
	      {
	        "title": "ChatGPT-steered Editing Instructor for Customization of Abstractive\n  Summarization",
	        "url": "https://huggingface.co/papers/2305.02483",
	        "authors": [
	          "Wen Xiao",
	          "Yujia Xie",
	          "Giuseppe Carenini"
	        ],
	        "pdf_url": "https://arxiv.org/pdf/2305.02483.pdf",
	        "abstract": "",
	        "upvotes": 3,
	        "pdf-file-location": "papers/2023-05-04/ChatGPT-steered_Editing_Instructor_for_Customization.pdf"
	      },
	    ]
	  }
	  ```