# RAPIDS Runtime

The Community RAPIDS Edition Runtimes are built on top of community built RAPIDS docker images. The RAPIDS suite of software libraries gives you the freedom to execute end-to-end data science and analytics pipelines entirely on GPUs. It relies on NVIDIA CUDA primitives for low-level compute optimization, but exposes that GPU parallelism and high-bandwidth memory speed through user-friendly Python interfaces.

```
Note
RAPIDS require NVIDIA Pascal or better GPUs. You need to use P3 or newer EC2 instances on AWS to meet this requirement.
```

## Runtime variants

Community RAPIDS Edition is available via two ML Runtime variants:
- PBJ Workbench Editor: `docker.io/peterableda/pbj-workbench-rapids:2023.06.7`
