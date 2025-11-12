
#Stage 1: Build container

FROM node:18-alpine AS build

WORKDIR /app

# Copy only package files for caching
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code (NOT .env)
COPY . .


# Stage 2: Run container

FROM node:18-alpine

WORKDIR /app

# Copy built app
COPY --from=build /app /app

# Expose port
EXPOSE 5000

# Start the app
CMD ["node", "index.js"]
