# Build Examples

# VsCode for ML runtimes

docker build -t <my docker repos>/vscode:2023.08.1 . -f Dockerfile-runtime-pbj-python39

CML Build based on "docker.repository.cloudera.com/cdsw/ml-runtime-workbench-python3.7-standard:2021.09.1-b5" uploaded on : 

   ghcr.io/oliviermeignan/vscode:2022.03.1

CML Build based on "docker.repository.cloudera.com/cloudera/cdsw/ml-runtime-pbj-workbench-python3.10-standard:2023.05.2-b7" available here:

   ghcr.io/ogakulov/vscode:2023.08.1

# Vscode for  CDSW Engine

docker push  <my docker repos>/vscode:2022.03.1