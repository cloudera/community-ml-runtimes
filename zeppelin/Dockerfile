# Dockerfile

# Base runtime image is the latest maintenance release from Cloudera
FROM docker.repository.cloudera.com/cdsw/ml-runtime-workbench-python3.7-standard:2021.09.1-b5

# Define zeppelin home location
ENV ZEPPELIN_HOME=/opt/zeppelin

# Download and unpack Zeppelin.
RUN mkdir -p "$ZEPPELIN_HOME" && \
      curl -sL https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz | tar -xz -C "$ZEPPELIN_HOME" --strip-components=1


# Add launch script and zeppling server parameters
ADD run-zeppelin.sh $ZEPPELIN_HOME/run-zeppelin.sh
ADD zeppelin-site.xml $ZEPPELIN_HOME/conf


# User cdsw will be running everything on pod initialization, and needs permissions
RUN chown -RL cdsw:cdsw $ZEPPELIN_HOME && chmod u+x $ZEPPELIN_HOME/run-zeppelin.sh 


# Create symlink to editor launch script
RUN ln -sf $ZEPPELIN_HOME/run-zeppelin.sh /usr/local/bin/ml-runtime-editor


# Override Runtime label and environment variables metadata
ENV ML_RUNTIME_EDITION="Community runtime with Apache Zeppling 0.10.1" \
    ML_RUNTIME_SHORT_VERSION="1.0" \
    ML_RUNTIME_MAINTENANCE_VERSION=1 \
    ML_RUNTIME_DESCRIPTION="Includes Apache Zeppelin (v0.10.1) as the default editor, along with all base librarires and interpreters."\
    ML_RUNTIME_EDITOR="Zeppelin"
ENV ML_RUNTIME_FULL_VERSION="${ML_RUNTIME_SHORT_VERSION}.${ML_RUNTIME_MAINTENANCE_VERSION}"
LABEL com.cloudera.ml.runtime.edition=$ML_RUNTIME_EDITION \
      com.cloudera.ml.runtime.full-version=$ML_RUNTIME_FULL_VERSION \
      com.cloudera.ml.runtime.short-version=$ML_RUNTIME_SHORT_VERSION \
      com.cloudera.ml.runtime.maintenance-version=$ML_RUNTIME_MAINTENANCE_VERSION \
      com.cloudera.ml.runtime.description=$ML_RUNTIME_DESCRIPTION \
      com.cloudera.ml.runtime.editor=$ML_RUNTIME_EDITOR
