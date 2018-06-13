ARG BUILD_FROM=hassioaddons/base-amd64:latest
FROM ${BUILD_FROM}

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        avahi-dev \
        g++ \
        libffi-dev \
        make \
        openssl-dev \
        python \
    \
    && apk add --no-cache \
        avahi \
        avahi-compat-libdns_sd \
        dbus \
        git \
        sed \
        nodejs \
        nodejs-npm \
    \
    && npm set unsafe-perm true \
    \
    && npm -g install \
        node-gyp \
        node-red \
        node-red-admin \
    \
    && npm cache clean -f && \
        npm install -g n && \
        n stable \
    \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="NodeRed" \
    io.hass.description="Hass.io Addons Node-red support HomeKit" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Charley <2555085@gmail.com>" \
    org.label-schema.description="Hass.io Addons Node-red support HomeKit" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="NodeRed" \
    org.label-schema.schema-version="0.1.1" \
    org.label-schema.url="http://bbs.hassbian.com" \
    org.label-schema.usage="http://bbs.hassbian.com" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="http://bbs.hassbian.com" \
    org.label-schema.vendor="Community Hass.io Add-ons"
