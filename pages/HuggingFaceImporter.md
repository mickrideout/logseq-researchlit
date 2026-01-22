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
			- skip the paper if 'github_repo' attribute doesnt exist
			- if there is a 'pdf-file-location' submit the pdf for importing via the researchlit api
			- if the "pdf_url" key has a value like "https://arxiv.org/pdf/2312.02120.pdf", the arxiv_id is 2312.02120
			- after the pdf file has been processed, update the papers.attributes and overwrite this section:
				- ```
				  {
				      "extractions": {
				          "code_repository_found": true,
				          "code_repository": "<insert github_repo value>",
				      }
				  }
				  ```
- ## Example Data
	- ```json
	  {
	    "date": "2023-12-05",
	    "papers": [
	      {
	        "title": "Magicoder: Source Code Is All You Need",
	        "url": "https://huggingface.co/papers/2312.02120",
	        "authors": [],
	        "pdf_url": "https://arxiv.org/pdf/2312.02120.pdf",
	        "abstract": "",
	        "upvotes": 82,
	        "github_repo": "https://github.com/ise-uiuc/magicoder",
	        "pdf-file-location": "papers/2023-12-05/Magicoder_Source_Code_Is_All.pdf"
	      },
	      {
	        "title": "VMC: Video Motion Customization using Temporal Attention Adaption for\n  Text-to-Video Diffusion Models",
	        "url": "https://huggingface.co/papers/2312.00845",
	        "authors": [
	          "Jong Chul Ye"
	        ],
	        "pdf_url": "https://arxiv.org/pdf/2312.00845.pdf",
	        "abstract": "",
	        "upvotes": 39,
	        "github_repo": "https://github.com/HyeonHo99/Video-Motion-Customization",
	        "pdf-file-location": "papers/2023-12-05/VMC_Video_Motion_Customization_using.pdf"
	      },
	      {
	        "title": "FaceStudio: Put Your Face Everywhere in Seconds",
	        "url": "https://huggingface.co/papers/2312.02663",
	        "authors": [
	          "Yuxuan Yan",
	          "Pei Cheng",
	          "Bin Fu"
	        ],
	        "pdf_url": "https://arxiv.org/pdf/2312.02663.pdf",
	        "abstract": "",
	        "upvotes": 32,
	        "github_repo": "https://github.com/xyynafc/FaceStudio",
	        "pdf-file-location": "papers/2023-12-05/FaceStudio_Put_Your_Face_Everywhere.pdf"
	      },
	    ]
	  }
	  ```