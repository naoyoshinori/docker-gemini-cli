ARG VARIANT=22-bookworm
FROM mcr.microsoft.com/devcontainers/typescript-node:${VARIANT}

ARG NODE_MODULES="@google/gemini-cli"
RUN su node -c "umask 0002 && npm install -g ${NODE_MODULES}" \
    && npm cache clean --force > /dev/null 2>&1
