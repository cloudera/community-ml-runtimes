FROM rapidsai/rapidsai:23.06-cuda11.8-base-ubuntu20.04-py3.10

USER root

# Install Runtime infra dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  krb5-user ssh xz-utils

# Configure pip to install packages under /usr/local
# when building the Runtime image
RUN pip3 config set install.user false

# Associate uid and gid 8536 with username cdsw
RUN \
  addgroup --gid 8536 cdsw && \
  adduser --disabled-password --gecos "CDSW User" --uid 8536 --gid 8536 cdsw

# Relax permissions to facilitate installation of Cloudera
# client files at startup
RUN for i in /bin /opt /usr /usr/share/java; do \
  mkdir -p ${i}; \
  chown cdsw ${i}; \
  chmod +rw ${i}; \
  for subfolder in `find ${i} -type d` ; do \
  chown cdsw ${subfolder}; \
  chmod +rw ${subfolder}; \
  done \
  done

RUN for i in /etc /etc/alternatives; do \
  mkdir -p ${i}; \
  chmod 777 ${i}; \
  done

RUN \
  source /opt/conda/etc/profile.d/conda.sh && \
  rm -rf ~/.condarc && \
  conda activate rapids && \
  mamba install --yes py4j=0.10.9.7 jupyter_kernel_gateway==2.5.2

# Final touches are done by the cdsw user to avoid
# permission issues in CML
USER cdsw

# Set up Python symlink to /usr/local/bin/python3
RUN ln -s /opt/conda/envs/rapids/bin/ipython3 /usr/local/bin/ipython3
RUN ln -s /opt/conda/envs/rapids/bin/python3 /usr/local/bin/python3
RUN ln -s /opt/conda/envs/rapids/bin/jupyter /usr/local/bin/jupyter

# configure pip to install packages to /home/cdsw
# once the Runtime image is loaded into CML
RUN /bin/bash -c "echo -e '[install]\nuser = true'" > /etc/pip.conf

# Set Runtime label and environment variables metadata
#ML_RUNTIME_EDITOR and ML_RUNTIME_METADATA_VERSION must not be changed.
ENV ML_RUNTIME_EDITOR="PBJ Workbench" \
  ML_RUNTIME_METADATA_VERSION="2" \
  ML_RUNTIME_KERNEL="Python 3.10" \
  ML_RUNTIME_EDITION="Community RAPIDS" \
  ML_RUNTIME_SHORT_VERSION="2023.06" \
  ML_RUNTIME_MAINTENANCE_VERSION="7" \
  ML_RUNTIME_JUPYTER_KERNEL_GATEWAY_CMD="/usr/local/bin/jupyter kernelgateway" \
  ML_RUNTIME_JUPYTER_KERNEL_NAME="python3" \
  ML_RUNTIME_DESCRIPTION="Community RAPIDS Runtime"


ENV ML_RUNTIME_FULL_VERSION="$ML_RUNTIME_SHORT_VERSION.$ML_RUNTIME_MAINTENANCE_VERSION"

LABEL com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR \
  com.cloudera.ml.runtime.kernel=$ML_RUNTIME_KERNEL \
  com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
  com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
  com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
  com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
  com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION \
  com.cloudera.ml.runtime.runtime-metadata-version=$ML_RUNTIME_METADATA_VERSION
