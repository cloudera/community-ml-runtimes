# Conda Runtimes for JupyterLab and CML Workbench
Custom ML runtime for use with Cloudera Data Platform Machine Learning (CML) or Data Science Workbench (CDSW).

This custom ML Runtime example demonstrates how to add the Conda package manager for use with CDSW and CML using wither the stock workbench or JupyterLab.

1. Build either or both of the Dockerfiles (Workbench and JupyterLab)
2. Push the image(s) to a repository
3. Add the runtime to CDSW/CML
4. From a Project, open a new Python 3.9 session and select this ML runtime

A pre-built version of the JupyterLab Conda runtime is published to:
`docker.io/peterableda/conda-runtime:5`



# JupyterLab Conda Runtimes
The Conda ML Runtime is configured with the conda-forge channel by default.
```
cdsw@ry8tgfl7c2ncx03s:~$ conda config --show channels
channels:
  - conda-forge
```

## Example setup
You can create new conda environments with the conda create command:
```
cdsw@nc4rzkyobsy592kv:~$ conda create --name condapy3.10
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /home/cdsw/.conda/envs/condapy3.10


Proceed ([y]/n)? y

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate condapy3.10
#
# To deactivate an active environment, use
#
#     $ conda deactivate
```

In your new environment you need to install `ipykernel`:
 ```
(base) cdsw@nc4rzkyobsy592kv:~$ conda activate condapy3.10
(condapy3.10) cdsw@nc4rzkyobsy592kv:~$ conda install ipykernel
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /home/cdsw/.conda/envs/condapy3.10

  added / updated specs:
    - ipykernel
(...)
```

Register the kernel spec with Jupyter. The --name= argument will set the name you see in JupyterLab  as the kernel.

```
(condapy3.10) cdsw@nc4rzkyobsy592kv:~$ ipython kernel install --user --name=condapy3.10
Installed kernelspec condapy3.10 in /home/cdsw/.local/share/jupyter/kernels/condapy3.10
```

If the new kernel is not showing up automatically executing the following command triggers a refresh.
```jupyter kernelspec list```

## Other kernels
The Conda Runtime supports other languages and kernels too.

For example creating an R environment and to use R notebooks you can follow this guide:
https://izoda.github.io/site/anaconda/r-jupyter-notebook/

## Known limitations
The following cml libraries won't be available in the newly created conda environments therefor the CML capabilities that depend on these won't work.
- [cml library](https://docs.cloudera.com/machine-learning/cloud/mlde/topics/ml-mlde-using-snippet.html) for Data connections
- [cml library](https://docs.cloudera.com/machine-learning/cloud/distributed-computing/topics/ml-workers-api.html) for distributed workloads
- [cmlapi library](https://docs.cloudera.com/machine-learning/cloud/api/topics/ml-api-v2.html) for programmatic API access
- [mlflow library](https://docs.cloudera.com/machine-learning/cloud/experiments/topics/ml-experiments-v2.html) for Experiment tracking

The kernels and all packages within the conda environment is persisted in the user's home directory which is backed up in NFS, this increases storage requirements for user Projects and have unknown performance implications.

Jobs, Applications and Models use the ML Runtime's python kernel, they don't automatically pick up the right conda environments for the workloads. There are workarounds that you need to apply to execute your code with the conda environment of your choice.

## Troubleshooting
To troubleshoot issues you can use the `jupyter kernelspec` command line utility.


# Workbench Conda Runtimes
This runtime installs the conda package manager and configures it to be available for installing packages.

TODO: configure the Workbench to pick up the conda installed packages.
