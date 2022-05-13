## Name: Python 3.7 with Tensorflow and Keras code samples for Cloudera CML Runtime Engine

## Description: Python 3.7 with Tensorflow and Keras code samples for Cloudera CML Runtime Engine

## Solves: Quickly get a head start with Tensorflow Keras by using pre-loaded libraries and Keras code samples

### On luanching the ML runtime Keras.io examples available in folder /home/keras/examples

   Code samples copied from https://github.com/keras-team/keras-io
   - Computer Vision
   - Natural Language Processing
   - Structured Data
   - Timeseries
   - Audio Data
   - Generative Deep Learning
   - Reinforcement Learning
   - Graph Data
   - Quick Keras Recipes

## CML Build based on "docker.repository.cloudera.com/cdsw/ml-runtime-workbench-python3.7-standard:2021.09.1-b5". Build by:
 
   docker build -t \<my docker repos\>/tf-keras:1.0 . -f Dockerfile
   
   docker push  docker.io/\<my docker repos\>/tf-keras:1.0
   
   docker.io/\<my docker repos\>/tf-keras:1.0
