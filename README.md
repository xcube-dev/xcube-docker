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

## Release steps

__Step 1__:

Create a branch and make your changes. Once finished change versions in 
.travis.yml as well as Dockerfile.

Test build locally by using 

```bash
    conda install --use-local xcube
```

__Step 2__:

Generate a pull request and wait for it to be reviewed and finally accepted.

__Step 3__: 

The conda package will automatically built on a push to master. When that is finished
the admin should generate a version tag.

__Step 4__:

Test the packages by running the following install command on windows,
OSX, and Linux. Ideally for Python versions 3.6 and 3.7.    

```bash
    conda install -c bcdev xcube
```
