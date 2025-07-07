FROM instrumentisto/rust:nightly-slim-2022-12-13 AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y libpq-dev
COPY Cargo.toml Cargo.lock .
COPY src ./src
COPY migrations ./migrations
RUN cargo update --dry-run # trigger crates.io index update
RUN cargo build --release

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/IAME_Election_Backend_Rocket /app/app
COPY .env /app/.env
CMD ["./app"]
