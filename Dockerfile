# Base image
FROM node:22-slim AS hafapp
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run compile

# Sync
FROM node:22-slim AS hafapp_sync
WORKDIR /app
COPY --from=hafapp /app ./
CMD ["npm", "start"]
