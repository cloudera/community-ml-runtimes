## Tensorflow Keras runtime on Python 3.7 with Keras code samples for Cloudera CML Workbench

This custom ML runtime for Cloudera CML comes preloaded with Tensorflow Keras libraries on Python 3.7 and Keras code samples to get you up and running quickly.

## Get Started 
   Also refer to [Public Docs](https://docs.cloudera.com/machine-learning/cloud/runtimes/topics/ml-creating-a-customized-runtimes-image.html)
   
   ### Build the Dockefile and push to Docker IO registry or similar
   
   docker build -t \<my docker repos\>/tf-keras:1.0 . -f Dockerfile
   
   docker push  docker.io/\<my docker repos\>/tf-keras:1.0
   
   ### Add the custom ML runtime to the environment in CML 
   
   - In Cloudera CML click **Runtime Catalog** from the **Navigation** panel.
   - Click the **Add Runtime** button in the upper right corner.
   - In the **Add Runtime** window, enter the url of the Runtime Docker image you want to upload.
   
   docker.io/\<my docker repos\>/tf-keras:1.0
   
   ### Create a new Project in CML and add the custom ML runtime
   
   - In Cloudera CML create a new Project 
   - Give the Project a name and in the **Runtime Setup** secition under **Advanced** option, add the custom ML runtime to your project
   - Click Create **Project**
   - From your Project, open a new Python 3.7 Workbench session and select the ML runtime

   ### From your Project, open a new Python 3.7 Workbench session and select this ML runtime. 
   
   Give the session enough resources as some of the code processing can be resource intensive. To bring the Kears code examples into you CML file view for easy viewing and editing you can open a terminal window in your session and run the following command: 
   
   cp -r /home/keras/keras.io /home/cdsw/ 
   
   Code samples are preloaded into /home/keras/examples from https://github.com/keras-team/keras-io and are grouped into the following categories:
   - Computer Vision
   - Natural Language Processing
   - Structured Data
   - Timeseries
   - Audio Data
   - Generative Deep Learning
   - Reinforcement Learning
   - Graph Data
   - Quick Keras Recipes
