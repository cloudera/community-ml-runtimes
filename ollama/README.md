# Ollama PBJ CUDA Runtime in CML
Ollama provides an easy mechanism to set up local selfhosted / private LLMs and multi-modal Models. This runtime setsup the Ollama binaries, the associated CUDA and recommended python libraries for accessing OLLAMA in CML. 

## Why do we need this runtime?
Ollama cannot be set up by a pip ihstall and binary installation on Linux requires sudo access which is not available by default in a CML Terminal for security reasons. 
This runtime sets up Ollama, associated CUDA libraries and compatible python versions so that you can add them to your CML workspace for use.

## References: 
1. Know more about about  [ollama](!https://ollama.com/)
2. For an example community runtime (docker login required) refer  [here](!https://hub.docker.com/repository/docker/superellipse/cml-pbj-cuda-ollama/general)
