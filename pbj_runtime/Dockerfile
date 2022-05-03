FROM jupyter/datascience-notebook:python-3.9.10

USER root

# The UID and username must match user.uid and user.username in
# config/internal-config.yml To avoid conflicts, this defaults to 8536 after 0.8
# release.
RUN \
 addgroup --gid 8536 cdsw && \
 adduser --disabled-password --gecos "CDSW User" --uid 8536 --gid 8536 cdsw


# MLX-50 Allow the engine image to be run as user cdsw upon startup.
# To do this we must 'chmod 777' /etc related directories.
RUN for i in /etc /etc/alternatives /opt/conda ; do \
 if [ -d ${i} ]; then chmod 777 ${i}; fi; \
 done

# DSE-11162 Base engine changes to support runtime addons.
# To do this, we must 'chown cdsw' some directories.
# Make root directory read/writable by cdsw user
RUN chown cdsw /

# Add permissions to cdsw user recursively to the common directories that gets touched as part
# of the engine startup process.
RUN for i in /bin /etc /opt /sbin /usr; do \
 if [ -d ${i} ]; then \
   chown cdsw ${i}; \
   find ${i} -type d -exec chown cdsw {} +; \
 fi; \
 done

RUN chown -R 8536:8536 /opt/conda

WORKDIR /


ENV DEBIAN_FRONTEND=noninteractive \
   LC_ALL=en_US.UTF-8 LANG=C.UTF-8 LANGUAGE=en_US.UTF-8 \
   TERM=xterm


RUN apt-get update && apt-get dist-upgrade -y && \
 apt-get update && apt-get install -y --no-install-recommends \
 locales \
 # Add your favourite OS packages here
 && apt-get clean && \
 apt-get autoremove && \
 rm -rf /var/lib/apt/lists/* && \
 echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Nuke the dummy krb5.conf that gets placed.
RUN rm -f /etc/krb5.conf


# Ln -s the ca-certificates to where curl expects to find them (!)
RUN mkdir -p /etc/pki/tls/certs
RUN ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt


# (DSE-2017) Symlink libsasl2.so.2 to libsasl2.so.3. Even though cyrus-sasl has
# only reached version 2.1.27, on centos/rhel yum install cyrus-sasl brings in
# libsasl2.so.3 and libsasl2.so.3.0.0. These filenames seem to be hardcoded into
# impala-shell. Since the problem is simply an incorrect version number, and it
# is not possible to conflict since cyrus-sasl 3 does not exist yet, this solves
# the problem.
RUN ln -s /usr/lib/x86_64-linux-gnu/libsasl2.so.2 /usr/lib/x86_64-linux-gnu/libsasl2.so.3

ENV SHELL /bin/bash
RUN pip3 install --no-cache-dir  jupyter-kernel-gateway==2.5.1 impyla[kerberos]==0.17.0 py4j==0.10.9.1
RUN apt-get remove -y tini


ENV MPLCONFIGDIR=/home/cdsw/.cache \
    XDG_CACHE_HOME=/home/cdsw/.cache \
    NB_USER=cdsw


ENV PYTHON3_VERSION=3.9.10 \
   ML_RUNTIME_KERNEL="Python 3.9.10" \
   ML_RUNTIME_EDITION=Standard \
   ML_RUNTIME_DESCRIPTION="Runtimes rock!"

ENV ML_RUNTIME_EDITOR="PBJ Workbench" \
   ML_RUNTIME_EDITION="Tech Preview" \
   ML_RUNTIME_KERNEL="Python 3.9.10" \
   ML_RUNTIME_JUPYTER_KERNEL_NAME="python3" \
   ML_RUNTIME_JUPYTER_KERNEL_GATEWAY_CMD="jupyter kernelgateway --config=/home/cdsw/.jupyter/jupyter_kernel_gateway_config.py --debug" \
   ML_RUNTIME_DESCRIPTION="Custom PBJ Workbench R runtime provided by Cloudera" \
   JUPYTERLAB_WORKSPACES_DIR=/tmp

ENV \
   ML_RUNTIME_METADATA_VERSION=2 \
   ML_RUNTIME_FULL_VERSION=1.1.1 \
   ML_RUNTIME_SHORT_VERSION=1.1 \
   ML_RUNTIME_MAINTENANCE_VERSION=1 \
   ML_RUNTIME_GIT_HASH=0 \
   ML_RUNTIME_GBN=0

LABEL \
   com.cloudera.ml.runtime.runtime-metadata-version=$ML_RUNTIME_METADATA_VERSION \
   com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR \
   com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
   com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION \
   com.cloudera.ml.runtime.kernel=$ML_RUNTIME_KERNEL \
   com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
   com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
   com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
   com.cloudera.ml.runtime.git-hash=$ML_RUNTIME_GIT_HASH \
   com.cloudera.ml.runtime.gbn=$ML_RUNTIME_GBN \
   com.cloudera.ml.runtime.cuda-version=$ML_RUNTIME_CUDA_VERSION

