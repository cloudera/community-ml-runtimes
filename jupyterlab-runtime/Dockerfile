FROM docker.repository.cloudera.com/cloudera/cdsw/ml-runtime-jupyterlab-python3.9-standard:2021.12.1-b17

USER root

# Upgrade packages in the base image
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add the packages you want to include in this runtime
# RUN pip install

# Override Runtime label and environment variables metadata
ENV ML_RUNTIME_EDITION="ML Runtime with JupyterLab Edition" \
    ML_RUNTIME_SHORT_VERSION="1" \
    ML_RUNTIME_MAINTENANCE_VERSION="0" \
    ML_RUNTIME_FULL_VERSION="1.0" \
    ML_RUNTIME_DESCRIPTION="This is a sample template to build a ML Runtime"


LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
      com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
      com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
      com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
      com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION
