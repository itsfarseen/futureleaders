# ──────── Builder ─────────
FROM node:16-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn && yarn build

# ──────── Production ─────────
FROM caddy:2-alpine

# Copy built assets into Caddy's web root
COPY --from=builder /app/dist /usr/share/caddy

# Copy your Caddy config in
COPY Caddyfile /etc/caddy/Caddyfile

# Let Caddy read BACKEND from env
ENV BACKEND=http://backend:5000

# Expose HTTP port
EXPOSE 80

# (Caddy’s default CMD will pick up /etc/caddy/Caddyfile)

