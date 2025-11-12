# Stage 1 — Build React App

FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy only package files for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build optimized production bundle
RUN npm run build


# Stage 2 — Serve with NGINX

FROM nginx:stable-alpine

# Clean default nginx static directory
RUN rm -rf /usr/share/nginx/html/*

# Copy compiled build from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config (optional but recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port (used by Kubernetes service)
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
