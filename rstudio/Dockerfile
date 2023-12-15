# ###########################################################################
#
#  CLOUDERA COMMUNITY RUNTIMES
#
# (C) Cloudera, Inc. 2022
#  All rights reserved.
#
#  Applicable Open Source License: Apache 2.0
#
#  NOTE: Cloudera open source products are modular software products
#  made up of hundreds of individual components, each of which was
#  individually copyrighted.  Each Cloudera open source product is a
#  collective work under U.S. Copyright Law. Your license to use the
#  collective work is as provided in your written agreement with
#  Cloudera.  Used apart from the collective work, this file is
#  licensed for your use pursuant to the open source license
#  identified above.
#
#  This code is provided to you pursuant a written agreement with
#  (i) Cloudera, Inc. or (ii) a third-party authorized to distribute
#  this code. If you do not have a written agreement with Cloudera nor
#  with an authorized and properly licensed third party, you do not
#  have any rights to access nor to use this code.
#
#  Absent a written agreement with Cloudera, Inc. (“Cloudera”) to the
#  contrary, A) CLOUDERA PROVIDES THIS CODE TO YOU WITHOUT WARRANTIES OF ANY
#  KIND; (B) CLOUDERA DISCLAIMS ANY AND ALL EXPRESS AND IMPLIED
#  WARRANTIES WITH RESPECT TO THIS CODE, INCLUDING BUT NOT LIMITED TO
#  IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY AND
#  FITNESS FOR A PARTICULAR PURPOSE; (C) CLOUDERA IS NOT LIABLE TO YOU,
#  AND WILL NOT DEFEND, INDEMNIFY, NOR HOLD YOU HARMLESS FOR ANY CLAIMS
#  ARISING FROM OR RELATED TO THE CODE; AND (D)WITH RESPECT TO YOUR EXERCISE
#  OF ANY RIGHTS GRANTED TO YOU FOR THE CODE, CLOUDERA IS NOT LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR
#  CONSEQUENTIAL DAMAGES INCLUDING, BUT NOT LIMITED TO, DAMAGES
#  RELATED TO LOST REVENUE, LOST PROFITS, LOSS OF INCOME, LOSS OF
#  BUSINESS ADVANTAGE OR UNAVAILABILITY, OR LOSS OR CORRUPTION OF
#  DATA.
#
#
############################################################################

FROM ubuntu:22.04
USER root

# https://github.com/phusion/baseimage-docker/issues/319
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"
ENV R_VERSION 4.3.1

# Install Python
# Note that the package python-is-python3 will alias python3 as python
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y software-properties-common wget ssh xz-utils krb5-user
RUN apt-get install -y --no-install-recommends python3 python3-pip python-is-python3 python3-venv

# https://stackoverflow.com/questions/43356982/docker-python-set-utf-8-locale
RUN apt-get -y install  --no-install-recommends locales
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

# Configure pip to install packages under /usr/local
# when building the Runtime image
RUN pip3 config set install.user false

# Install the Jupyter kernel gateway.
# The IPython kernel is automatically installed 
# under the name python3,
# so below we set the kernel name to python3.
RUN pip3 install jupyter-kernel-gateway==2.5.2

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

# Install R 
RUN apt-get install -y --no-install-recommends software-properties-common dirmngr gdebi-core
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc |  tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

RUN apt-get install -y r-base r-base-core r-recommended r-base-dev

# Install RStudio
RUN wget -q https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.09.1-494-amd64.deb
RUN gdebi -n rstudio-server-2023.09.1-494-amd64.deb
RUN rm rstudio-server-2023.09.1-494-amd64.deb

# Add additiona R repos
# add-apt-repository ppa:c2d4u.team/c2d4u4.0+

# Configure RStudio to work in CML
# RStudio needs some changes made to the default configuration to work in CML, e.g.
# port and host info. This is set in the two additonal files that are added to the image.

RUN chown -R cdsw:cdsw /var/lib/rstudio-server && chmod -R 777 /var/lib/rstudio-server
COPY rserver.conf /etc/rstudio/rserver.conf
COPY rstudio-cml /usr/local/bin/rstudio-cml
RUN chmod +x /usr/local/bin/rstudio-cml


# Create a Symlink to the default editor launcher
# This is the main requirement to get CML to launch a different editor. Create a symlink
# from the editors launcher to /usr/local/bin/ml-runtime-editor
RUN ln -s /usr/local/bin/rstudio-cml /usr/local/bin/ml-runtime-editor

# Install additional R dependencies
COPY r-runtime-dependencies.txt /build/

# Fix: E: Unable to locate package libicu66 (in Ubuntu 22.04 has been renamed to libicu70)
RUN sed -i 's/libicu66/libicu70/g' /build/r-runtime-dependencies.txt

# Build dependencies
RUN \
    apt-get update && \
    cat /build/r-runtime-dependencies.txt | \
      sed '/^$/d; /^#/d; s/#.*$//' | \
      xargs apt-get install -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /build

# Change permissions to allow env variables to be pushed to Renviron.site file
# when the rstudio-cml startup file is run
RUN chmod -R 666 /etc/R/Renviron.site

RUN chmod 777 /usr/local/bin/rstudio-cml

# Final touches are done by the cdsw user to avoid
# permission issues in CML
ENV USER cdsw
USER cdsw


# Set up Python symlink to /usr/local/bin/python3
RUN ln -s $(which python) /usr/local/bin/python3

# configure pip to install packages to /home/cdsw
# once the Runtime image is loaded into CML
RUN /bin/bash -c "echo -e '[install]\nuser = true'" > /etc/pip.conf


# Set Runtime label and environment variables metadata
#ML_RUNTIME_EDITOR and ML_RUNTIME_METADATA_VERSION must not be changed.
ENV ML_RUNTIME_EDITOR="PBJ Workbench" \
    ML_RUNTIME_METADATA_VERSION="2" \
    ML_RUNTIME_KERNEL="Python 3.10" \
    ML_RUNTIME_EDITION="Custom Edition" \
    ML_RUNTIME_SHORT_VERSION="1.0" \
    ML_RUNTIME_MAINTENANCE_VERSION="1" \
    ML_RUNTIME_JUPYTER_KERNEL_GATEWAY_CMD="/usr/local/bin/jupyter kernelgateway" \
    ML_RUNTIME_JUPYTER_KERNEL_NAME="python3" \
    ML_RUNTIME_DESCRIPTION="My first Custom PBJ Runtime"
          

ENV ML_RUNTIME_FULL_VERSION="$ML_RUNTIME_SHORT_VERSION.$ML_RUNTIME_MAINTENANCE_VERSION" 

LABEL com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR \
	    com.cloudera.ml.runtime.kernel=$ML_RUNTIME_KERNEL \
	    com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
	    com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
      com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
      com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
      com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION \
      com.cloudera.ml.runtime.runtime-metadata-version=$ML_RUNTIME_METADATA_VERSION

