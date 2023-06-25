FROM node:16-alpine AS builder
WORKDIR /app
COPY . /app
RUN yarn
RUN yarn build

FROM scratch AS output
COPY --from=builder /app/dist /
