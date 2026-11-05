# Workflows

## [Auto Update](./update.yml)

Runs daily or manually. Moves the image to the next Rust release and opens a PR for it.

1. Finds the next Rust release after our [`Dockerfile`](../../Dockerfile) version that has a `rust` Docker image.
    1. See [updateImage.sh](../../updateImage.sh). Releases are taken one at a time, so if we fall behind every
       skipped version still gets its own image.
2. Opens a PR as a GitHub App and enables auto merge.
    1. The PR is opened with an App token rather than `GITHUB_TOKEN` because events created by `GITHUB_TOKEN` don't
       trigger other workflows, so CI wouldn't run on the PR or on the merge to `main`.
    2. Requires the `APP_ID` variable and `APP_PRIVATE_KEY` secret.

## [Continuous Integration](./ci.yml)

Runs for every PR and merge to `main`.

1. Build the docker image
2. Test by building the [test](../../test) project using `wasm-pack build`
    1. During this test we block internet access to various sites to ensure all the necessary binaries are in the docker
       image. See [testImage.sh](../../testImage.sh).
3. On `main`, if the [`Dockerfile`](../../Dockerfile) Rust version has no tag yet:
    1. Build and push the image for each architecture to Docker Hub.
    2. Create a GitHub Release (and tag) for the version.
    3. Trigger [Auto Update](#auto-update) to pick up the next version, if there is one.
