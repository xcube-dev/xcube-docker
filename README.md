# xcube-conda
Repository for deploying xcube as a conda package

## Updating Process

- Make branch
- Change version in xcube/meta.yml
- push to branch and wait whether travis succeeds
- If so make a pull request
- Once the PR is accepted, travis will build and deploy the version to teh anaconda 
    cloud as architectures:
    - win64
    - osx64
    - linux64
    
    
## Usage

```bash

conda install -c bc-dev xcube

```

## Dependencies

- Can be run using python 3.6 and 3.7 and numpy 1.16
- For all dependencies see [meta.yaml](xcube/meta.yaml)