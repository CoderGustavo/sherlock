# Stage 1 - Build environment
FROM debian:latest AS build-env

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed && \
    rm -rf /var/lib/apt/lists/*

# Clone Flutter repository and set PATH
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Set Flutter to master channel and upgrade
RUN flutter channel master && \
    flutter upgrade

# Prepare and build the app
WORKDIR /app
COPY . .
RUN flutter pub get && \
    flutter build web

# Stage 2 - Run-time environment
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
