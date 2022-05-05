## Jupyterlab with extensions : Python debugger, Git integration, Language Server Protocol (LSP)

Read carefully the doc for a godd usage of these extensions


# Python debugger 

https://jupyterlab.readthedocs.io/en/latest/user/debugger.html


# Git Integration

https://github.com/jupyterlab/jupyterlab-git


# LSP language extension



    - Press Ctrl to get a tooltip with function/class signature, module documentation 
    - Use the context menu entry, or Alt + to jump to definitions/references 
    - Place your cursor on a variable, function, etc and all the usages will be highlighted
    - Certain characters, for example '.' (dot) in Python, will automatically trigger completion
    - Function signatures will automatically be displayed
    - Diagnostics panel

    More on : https://github.com/jupyter-lsp/jupyterlab-lsp


## Docker build for CML 


A cml Build is available on :

ghcr.io/oliviermeignan/jupyterlabgit:2022.05.4-b3

(Built using : docker build -t ghcr.io/oliviermeignan/jupyterlabgit:2022.05.4-b3 . -f Dockerfile)



