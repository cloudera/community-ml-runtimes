<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
# Ollama PBJ CUDA Runtime in Cloudera Machine Learning
Ollama provides an easy mechanism to set up local selfhosted / private LLMs and multi-modal Models. This runtime is used to setup the Ollama binaries, the associated CUDA and recommended python libraries for accessing OLLAMA in Cloudera Machine Learning. 
=======
<<<<<<< HEAD
`# Ollama PBJ CUDA Runtime in CML
=======
=======
>>>>>>> 8b72ce0 (updated Readme)
# Ollama PBJ CUDA Runtime in CML
=======
`# Ollama PBJ CUDA Runtime in CML
>>>>>>> a016c0c (updates to the file to include Ollama as a kernel service)
Ollama provides an easy mechanism to set up local selfhosted / private LLMs and multi-modal Models. This runtime is used to setup the Ollama binaries, the associated CUDA and recommended python libraries for accessing OLLAMA in CML. 
>>>>>>> 4189210 (Fixed Merge Conflict issues and also Comment on Docker Layer from Peter Ableda (#29))

## Why do we need this runtime?
Ollama cannot be set up by a pip install and its binary installation on Linux requires sudo access, which is not available by default in a Cloudera Machine Learning Terminal for security reasons. 
This runtime sets up Ollama, associated CUDA libraries and compatible python versions so that you can add them to your Cloudera Machine Learning workspace for use.



<<<<<<< HEAD
## Docker build for Cloudera Machine Learning 
=======
## Docker build for CML 
<<<<<<< HEAD
>>>>>>> 09dfcfe (merge)
A  build is available on dockerhub that can be accessed as follows ( needs docker login) by using the format _docker.io/your-dockerimagename-name:tag_ 

*A prebuilt version has been uploaded to the Docker hub and can can be accessed as follows*
```
docker.io/superellipse/ollama-serve-and-pull:v2.7
<<<<<<< HEAD
=======
<<<<<<< HEAD
docker.io/superellipse/ollama-serve-and-pull:v2.7
=======
docker.io/superellipse/cml-pbj-cuda-ollama:v1.2
>>>>>>> upstream/main
>>>>>>> 4189210 (Fixed Merge Conflict issues and also Comment on Docker Layer from Peter Ableda (#29))
```
## Adding the runtime image in Cloudera Machine Learning
To add a runtime image in Cloudera Machine Learning if it does not exist already, go to the runtime catalog in control pane, and click on add runtime. you can add the details as below. Replace the runtime image with your own image details and tags if you are building your own docker image.
=======
```
## Adding the runtime image in CML
To add a runtime image in CML if it does not exist already, go to the runtime catalog in control pane, and click on add runtime. you can add the details as below. Replace the runtime image with your own image details and tags if you are building your own docker image.
>>>>>>> 8b72ce0 (updated Readme)


 <br> <br>
![Adding Runtime](./picture/AddingRuntimeinCML.png)
<<<<<<< HEAD
=======
<<<<<<< HEAD
![Adding Runtime](./picture/AddingRuntimeinCML.png)
=======
![Adding Runtime](./picture/AddingRuntimeinCML.jpg)
>>>>>>> upstream/main

>>>>>>> 4189210 (Fixed Merge Conflict issues and also Comment on Docker Layer from Peter Ableda (#29))
=======
>>>>>>> 8b72ce0 (updated Readme)
<br><br>
## References: 
1. Click here to know more about [Ollama](https://www.ollama.com/)
<<<<<<< HEAD
2. For more details on this process and how to add this image to Cloudera Machine Learning, please refer to this [Cloudera Documentation Page](https://docs.cloudera.com/machine-learning/cloud/runtimes/topics/ml-runtimes-overview.html)
=======
2. For more detials on this process and how to add this image to CML, please refer to this [Cloudera Documentation Page](https://docs.cloudera.com/machine-learning/cloud/runtimes/topics/ml-runtimes-overview.html)
=======
A cml Build is available on dockerhub that can be accessed as follows ( needs docker login) as follows docker.io/<dockerimagename>:version

<<<<<<< HEAD
The current build is can be assesed as :
docker.io/superellipse/cml-pbj-cuda-ollama:v1.2

=======
*A Sample Build can of this runtime can be accessed as follows*
=======
>>>>>>> bc71c6a (Fixed the issues in Pull Request review)
```
docker.io/superellipse/ollama-serve-and-pull:v2.7
```
>>>>>>> a016c0c (updates to the file to include Ollama as a kernel service)
Built by vishrajagopalan( Github/docker handle - Superellipse) using the command
docker build -f Dockerfile -t cml-pbj-cuda-ollama:v1.2 .

## Adding the runtime image in CML
To add a runtime image in CML if it does not exist already, go to the runtime catalog in control pane, and click on add runtime. you can add the details as below. Replace the runtime image with your own image details and tags if you are building your own docker image.


 <br> <br>
![Adding Runtime](./picture/AddingRuntimeinCML.png)

<br><br>
## References: 
1. Know more about about  [ollama](!https://ollama.com/)
>>>>>>> 209d355 (updated ReadMe)
>>>>>>> 09dfcfe (merge)
