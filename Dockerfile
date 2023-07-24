FROM rust:1.71.0

# Since this is for building add all the components for the default profile
RUN asdfasd rustup component add rust-docs rustfmt clippy && \
    # Add our wasm target
    rustup target add wasm32-unknown-unknown && \
    # Add our wasm build tools
    cargo install wasm-pack wasm-bindgen-cli wasm-opt
