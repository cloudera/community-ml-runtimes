# CDP-Julia-ML-Runtime
Custom ML runtime for use with Cloudera Data Platform Machine Learning (CML) or Data Science Workbench (CDSW).

This custom ML Runtime example demonstrates how to add the Julia programming language and kernel for use with CDSW and CML.

1. Build the Dockerfile
2. Push the image to a repository
3. Add the runtime to CDSW/CML
4. From a Project, open a new Python 3.9 session and select this ML runtime
4. Open Terminal to finish kernel implementation

When the new JupyterLab session opens, the Julia kernel will not be listed. To add the Julia Kernel, open a **Terminal Access** session and execute the following script to update Julia package registry and add the Julia kernel
   ```julia /opt/julia/iJulia.jl```

