FROM docker.repository.cloudera.com/cloudera/cdsw/ml-runtime-jupyterlab-python3.9-standard:2021.12.1-b17

USER root

# Upgrade packages in the base image
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN pip install jupyterlab==3.4 --upgrade
RUN pip install jupyterlab-lsp==3.10.1 jupyterlab-git==0.37.1 ipykernel>=6 jedi-language-server==0.36.0 --upgrade


# Add the packages you want to include in this runtime
# RUN pip install

# Override Runtime label and environment variables metadata
ENV ML_RUNTIME_EDITOR="ML Runtime with JupyterLab extensions" \
    ML_RUNTIME_EDITION="Jupyterlab 3.4 with cool extensions" \
	 ML_RUNTIME_SHORT_VERSION="2022.05" \
	 ML_RUNTIME_MAINTENANCE_VERSION="2" \
    ML_RUNTIME_FULL_VERSION="2022.05.2" \
    ML_RUNTIME_DESCRIPTION="Jupyterlab 3.4 with cool extensions (git, lsp, debug)"

LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
      com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
      com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
      com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
      com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION
