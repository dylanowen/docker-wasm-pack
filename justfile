
build:
    #!/usr/bin/env bash
    set -euxo pipefail

    docker build \
        -t wasm-pack \
        -f ./Dockerfile .

run: build
    #!/usr/bin/env bash
    set -euxo pipefail

    docker run \
        --rm -it \
        -v {{justfile_directory()}}/test:/usr/src/myapp \
        --workdir /usr/src/myapp \
        wasm-pack
