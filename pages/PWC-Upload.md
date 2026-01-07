-
- **AIM**  - to add all PWC papers to researchlit... and make discoverable
- ### Requirements
	- Create a script that processes a json file that has an array of entries, an example shown below in the section 'paper-abstract-feed'
	- In the 'mappings' section below, the first item is the key in the json file, and the second item after the '->' is the destination in the database. For database tables that are json fields, create a json entry if one doesnt exist, otherwise, merge the json with the new entry. Replace the token 'INSERT DATA HERE>' with the value from the json file
	- Improve the paper matching for existing papers code. Match should be based on arxiv_id, title, doi or any other relevant matching details
	- Change the paper details page to display title, authors, year and abstract from the papers.text_extraction if the papers.attributes['extractions']['Abstract summary'] entry doesnt exist
- ### Mappings
	- arxiv_id -> papers.arxiv_id
	- title -> papers.title and also papers.text_extraction -> {'title': '<INSERT DATA HERE>'}
	- abstract -> papers.text_extraction -> {'abstract': '<INSERT DATA HERE>'}
	- urls_abs -> papers.url
	- tasks -> papers.attributes -> {'extractions': 'tasks': [<INSERT DATA HERE>]}
	- date -> papers.year
	- authors -> papers.authors
- ### Examples
	- **paper-abstract-feed**
		- ```
		   [ {
		      "paper_url": "https://paperswithcode.com/paper/dynamic-network-model-from-partial",
		      "arxiv_id": "1805.10616",
		      "nips_id": null,
		      "openreview_id": null,
		      "title": "Dynamic Network Model from Partial Observations",
		      "abstract": "Can evolving networks be inferred and modeled without directly observing\ntheir nodes and edges? In many applications, the edges of a dynamic network\nmight not be observed, but one can observe the dynamics of stochastic cascading\nprocesses (e.g., information diffusion, virus propagation) occurring over the\nunobserved network. While there have been efforts to infer networks based on\nsuch data, providing a generative probabilistic model that is able to identify\nthe underlying time-varying network remains an open question. Here we consider\nthe problem of inferring generative dynamic network models based on network\ncascade diffusion data. We propose a novel framework for providing a\nnon-parametric dynamic network model--based on a mixture of coupled\nhierarchical Dirichlet processes-- based on data capturing cascade node\ninfection times. Our approach allows us to infer the evolving community\nstructure in networks and to obtain an explicit predictive distribution over\nthe edges of the underlying network--including those that were not involved in\ntransmission of any cascade, or are likely to appear in the future. We show the\neffectiveness of our approach using extensive experiments on synthetic as well\nas real-world networks.",
		      "short_abstract": null,
		      "url_abs": "http://arxiv.org/abs/1805.10616v4",
		      "url_pdf": "http://arxiv.org/pdf/1805.10616v4.pdf",
		      "proceeding": "NeurIPS 2018 12",
		      "authors": [
		        "Elahe Ghalebi",
		        "Baharan Mirzasoleiman",
		        "Radu Grosu",
		        "Jure Leskovec"
		      ],
		      "tasks": [
		        "model",
		        "Open-Ended Question Answering"
		      ],
		      "date": "2018-05-27",
		      "conference_url_abs": "http://papers.nips.cc/paper/8192-dynamic-network-model-from-partial-observations",
		      "conference_url_pdf": "http://papers.nips.cc/paper/8192-dynamic-network-model-from-partial-observations.pdf",
		      "conference": "dynamic-network-model-from-partial-1",
		      "reproduces_paper": null,
		      "methods": [
		        {
		          "name": "ooJpiued",
		          "full_name": "ooJpiued",
		          "description": "Please enter a description about the method here",
		          "introduced_year": 2000,
		          "source_url": "http://arxiv.org/abs/1805.10616v4",
		          "source_title": "Dynamic Network Model from Partial Observations",
		          "code_snippet_url": null,
		          "main_collection": {
		            "name": "Language Models",
		            "description": "**Language Models** are models for predicting the next word or character in a document. Below you can find a continuously updating list of language models.\r\n\r\n",
		            "parent": null,
		            "area": "Natural Language Processing"
		          }
		        }
		      ]
		    },
		  ]
		  ```
		-