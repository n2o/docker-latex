# docker-latex

This is a base image, used for our GitLab CI as a shared runner. All packages
are included to build pdf-files with our paper-build repository.

## Build local image

```bash
$ docker build -t hhucn-latex .
```

This takes a while, since all packages from the Dockerfile need to be installed.

## Start local instance of the container

Connect to local container with a bash:

```bash
$ docker run -it hhucn-latex bash
```


