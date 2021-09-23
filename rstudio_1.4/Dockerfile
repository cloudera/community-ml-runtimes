# Start with a Base CML Runtime
# Note: This particular image will use the Python base image, not R as expected. There is a
# complication with CML that prevents editors and applications from launching if the CML 
# version of python isn't present. This should be fixed in a future release.
FROM docker.repository.cloudera.com/cdsw/ml-runtime-workbench-python3.7-standard:2021.06.1-b5

# Updated the images with apt-get
RUN apt-get update && apt-get upgrade -y

# Setup R Repos
RUN apt-get install -y --no-install-recommends software-properties-common dirmngr gdebi-core
RUN curl https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc > /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Install R
# Since this Dockerfile uses the CML Python base image, it is necessary to install R. This will 
# not install the # cdsw package used for managing experiments and models with R sessions. Given 
# that models and # experiments don't use R-Studio as the editor, this is not a problem. Just make 
# sure to keep consistency in R versions. The current CML R Runtime uses R 4.0.4, so that is the 
# target version to install
RUN apt-get install -y r-base-core=4.0.4-1.2004.0

# Install R Studio
RUN curl -O https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb
RUN gdebi -n rstudio-server-1.4.1717-amd64.deb

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

# Set the ENV and LABEL details for this Runtime
# The final requirement is to set various labels and environment variables that CML needs 
# to pick up the Runtime's details. Here the editor is to RStudio
ENV ML_RUNTIME_EDITOR="RStudio" \ 
ML_RUNTIME_EDITION="RStudio Community Runtime"	\ 
ML_RUNTIME_SHORT_VERSION="2021.09" \
ML_RUNTIME_MAINTENANCE_VERSION="3" \
ML_RUNTIME_FULL_VERSION="2021.09.3" \
ML_RUNTIME_DESCRIPTION="Testing RStudio" \
ML_RUNTIME_KERNEL="R 4.0"

LABEL com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR \
com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION \
com.cloudera.ml.runtime.kernel=$ML_RUNTIME_KERNEL