# Stage 1 - Build environment
FROM debian:latest AS build-env

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed && \
    rm -rf /var/lib/apt/lists/*

# Download and set up Flutter
ENV FLUTTER_VERSION=3.13.3
RUN curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C /usr/local/ && \
    rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Prepare and build the app
WORKDIR /app
COPY . .
RUN flutter pub get && \
    flutter build web

# Stage 2 - Run-time environment
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
