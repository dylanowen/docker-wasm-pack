# Workflows

## [Continuous Integration](./ci.yml)

Runs for every PR and merge to `main`.

1. Build the docker image
2. Test by building the [test](../../test) project using `wasm-pack build`
    1. During this test we block internet access to various sites to ensure all the necessary binaries are in the docker
       image. See [testImage.sh](../../testImage.sh).
3. If we're on the `main` branch AND our [`Dockerfile`](../../Dockerfile) has a later Rust version we create a new
   version tag for this commit.
    1. This happens as part of [createTag.sh](../../createTag.sh)
    2. Because Github Actions can't trigger other actions we use a custom Personal Access Token here. If this step is
       broken make sure the PAT hasn't expired.

## [Release](./release.yml)

Runs for every tag on the `main` branch. Tags on the `main` branch will trigger a deployment to Docker Hub.

1. Check if we're actually on the `main` branch for a tag.
2. Build and push our Docker image for each architecture.

## [Auto Update](./update.yml)

Runs daily or manually. This checks to see if there is a new Rust version and if so creates a PR for the new version.

1. Sets up the latest stable Rust
2. Attempts to update our image using the `rustc --version` output.
   1. See [updateImage.sh](../../updateImage.sh)
3. If there are any changes in our repo creates a new PR
4. Sets up the PR for auto merging.
