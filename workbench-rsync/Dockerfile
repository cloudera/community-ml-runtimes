FROM docker.repository.cloudera.com/cloudera/cdsw/ml-runtime-workbench-python3.9-standard:2022.11.2-b2 
RUN apt-get update && apt-get install -y --no-install-recommends rsync && apt-get clean && rm -rf /var/lib/apt/lists/* 
COPY third-party-notices.txt /notices/NOTICE.txt
ENV ML_RUNTIME_EDITION="Rsync"
LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION