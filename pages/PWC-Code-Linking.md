-
- **Task** - Modify the pwc import script to link paper to code repository url
- **Dataset** - links-between-papers-and-code.json - https://huggingface.co/datasets/pwc-archive/links-between-paper-and-code
- ### Requirements
-
- ### Dataset Example
	- ```json
	  [
	    {
	      "paper_url": "https://paperswithcode.com/paper/odyssey-a-public-gpu-based-code-for-general",
	      "paper_title": "Odyssey: A Public GPU-Based Code for General-Relativistic Radiative Transfer in Kerr Spacetime",
	      "paper_arxiv_id": "1601.02063",
	      "paper_url_abs": "https://arxiv.org/abs/1601.02063v2",
	      "paper_url_pdf": "https://arxiv.org/pdf/1601.02063v2.pdf",
	      "repo_url": "https://github.com/LeonGeiger/Kerr",
	      "is_official": false,
	      "mentioned_in_paper": false,
	      "mentioned_in_github": true,
	      "framework": "none"
	    },
	    {
	      "paper_url": "https://paperswithcode.com/paper/efficient-leave-one-out-cross-validation-for",
	      "paper_title": "Efficient leave-one-out cross-validation for Bayesian non-factorized normal and Student-t models",
	      "paper_arxiv_id": "1810.10559",
	      "paper_url_abs": "https://arxiv.org/abs/1810.10559v5",
	      "paper_url_pdf": "https://arxiv.org/pdf/1810.10559v5.pdf",
	      "repo_url": "https://github.com/paul-buerkner/psis-non-factorized-paper",
	      "is_official": true,
	      "mentioned_in_paper": true,
	      "mentioned_in_github": false,
	      "framework": "none"
	    },
	  ]
	  ```