FROM rustlang/rust:nightly-slim as planner
WORKDIR /app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare  --recipe-path recipe.json

FROM rustlang/rust:nightly-slim as cacher
WORKDIR /app
RUN cargo install cargo-chef
RUN apt-get update && apt-get install -y libpq-dev
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

FROM rustlang/rust:nightly-slim as builder
RUN apt-get update && apt-get install -y libpq-dev
WORKDIR /app
COPY . .
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo
RUN cargo build --release

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/IAME_Election_Backend_Rocket /app/app
COPY .env /app/.env
CMD ["./app"]
