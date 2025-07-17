FROM mcr.microsoft.com/devcontainers/typescript-node:1-22-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    xdg-utils \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN mkdir -p /home/node/gemini-cli /workspace && chown -R node:node /home/node/gemini-cli /workspace

WORKDIR /home/node/gemini-cli

COPY --chown=node:node package.json package-lock.json ./

USER node

RUN npm install --production

ENV PATH /home/node/gemini-cli/node_modules/.bin:$PATH

WORKDIR /workspace

CMD [ "bash" ]
