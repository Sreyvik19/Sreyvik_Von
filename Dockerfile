# Stage 1: Build SCSS to CSS (optional)
FROM node:18-alpine AS builder

WORKDIR /app

# Copy only SCSS/SASS
COPY scss/ ./scss/

# Install sass globally
RUN npm install -g sass

# Compile SCSS to CSS
RUN mkdir -p dist/css && \
    sass scss:dist/css


# Stage 2: Serve static files
FROM nginx:alpine

# Copy compiled CSS
COPY --from=builder /app/dist/css /usr/share/nginx/html/css

# Copy HTML, images, and other assets
COPY *.html /usr/share/nginx/html/
COPY image/ /usr/share/nginx/html/image/
COPY components/ /usr/share/nginx/html/components/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
