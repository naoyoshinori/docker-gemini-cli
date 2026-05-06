ARG VARIANT=22-bookworm
FROM mcr.microsoft.com/devcontainers/javascript-node:${VARIANT}

ARG USERNAME=node
ARG NODE_MODULES="@google/gemini-cli"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    bubblewrap \
    ripgrep \
    jq \
    tree \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN su node -c "umask 0002 && npm install -g ${NODE_MODULES}" \
    && npm cache clean --force > /dev/null 2>&1

USER ${USERNAME}
