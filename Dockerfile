# Base image
FROM node:18-slim AS hafapp
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Sync
FROM node:18-slim AS hafapp_sync
WORKDIR /app
COPY --from=hafapp /app ./
CMD ["npm", "start"]

# Server
FROM node:18-slim AS hafapp_server
WORKDIR /app
COPY --from=hafapp /app ./
ENV HAFAPP_HTTP_PORT=3010
EXPOSE ${HAFAPP_HTTP_PORT}
CMD ["npm", "run", "server"]