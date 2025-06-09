FROM debian:stable-slim
ARG VER
ARG TARGETPLATFORM
LABEL version="${VER}-${TARGETPLATFORM}"

ENV CHROME_DEBUG_PORT=9222

RUN apt-get update && \
    apt-get install -y wget unzip apt-transport-https ca-certificates curl gnupg chromium libgbm-dev --no-install-recommends --allow-unauthenticated && \
    wget -q -O chrome.zip https://storage.googleapis.com/chrome-for-testing-public/${VER}/linux64/chrome-linux64.zip && \
    unzip chrome.zip && \
    rm chrome.zip && \
    ln -sf ${PWD}/chrome-linux/chrome /usr/bin/chromium && \
    ln -sf /usr/bin/chromium /usr/bin/chromium-browser && \
    groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome/reports && \
    chown -R chrome:chrome /home/chrome &&\
    apt-get autoremove wget unzip -y

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

# Drop to cli
ENTRYPOINT ["entrypoint"]