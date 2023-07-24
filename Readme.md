# dylanowen/wasm-pack

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dylanowen/wasm-pack)](https://hub.docker.com/r/dylanowen/wasm-pack)

This is a simple Docker image for compiling rust wasm projects. The tag is the rustc version, ex: `1.70.0`.

## Usage

```shell
docker run \
    --rm -v \
    $(pwd):/usr/src/myapp \
    --workdir /usr/src/myapp \
    dylanowen/wasm-pack:latest \
    wasm-pack build
```

## Building

All the building happens automatically in [Github Actions](.github/workflows/Readme.md)
