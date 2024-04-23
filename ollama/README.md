# Ollama PBJ CUDA Runtime in CML
Ollama provides an easy mechanism to set up local selfhosted / private LLMs and multi-modal Models. This runtime setsup the Ollama binaries, the associated CUDA and recommended python libraries for accessing OLLAMA in CML. 

## Why do we need this runtime?
Ollama cannot be set up by a pip ihstall and binary installation on Linux requires sudo access which is not available by default in a CML Terminal for security reasons. 
This runtime sets up Ollama, associated CUDA libraries and compatible python versions so that you can add them to your CML workspace for use.



## Docker build for CML 
A cml Build is available on dockerhub that can be accessed as follows ( needs docker login) as follows docker.io/<dockerimagename>:version

The current build is can be assesed as :
docker.io/superellipse/cml-pbj-cuda-ollama:v1.2

Built by vishrajagopalan( Github/docker handle - Superellipse) using the command
docker build -f Dockerfile -t cml-pbj-cuda-ollama:v1.2 .

## Adding the runtime image in CML
To add a runtime image in CML if it does not exist already, go to the runtime catalog in control pane, and click on add runtime. you can add the details as below. Replace the runtime image with your own image details and tags if you are building your own docker image.


 <br> <br>
![Adding Runtime](./picture/AddingRuntimeinCML.jpg)

<br><br>
## References: 
1. Know more about about  [ollama](!https://ollama.com/)