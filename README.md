# Docker for Gemini CLI

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A ready-to-use and convenient Docker environment for [Google's Gemini CLI](https://github.com/google-gemini/gemini-cli) (`@google/gemini-cli`).

[This project](https://github.com/naoyoshinori/docker-gemini-cli) provides Docker images that let you use the Gemini CLI without installing Node.js on your system. It's designed for security and ease of use, running as a non-root user and offering seamless integration with VS Code Dev Containers. Three main variants are offered to suit different needs: a minimal image for direct execution and two feature-rich images for development.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Image Variants](#image-variants)
  - [`gemini-cli:<version>-node`](#gemini-cliversion-node)
  - [`gemini-cli:<version>-javascript-node`](#gemini-cliversion-javascript-node)
  - [`gemini-cli:<version>-typescript-node`](#gemini-cliversion-typescript-node)
- [Initial Setup](#initial-setup)
- [How to Use This Image](#how-to-use-this-image)
  - [Option 1: Start an Interactive Shell Session](#option-1-start-an-interactive-shell-session)
  - [Option 2: Run a Single Command](#option-2-run-a-single-command)
  - [Option 3: Use with `docker-compose`](#option-3-use-with-docker-compose)
  - [Option 4: Use as a VS Code Dev Container](#option-4-use-as-a-vs-code-dev-container)
- [Updating the Docker Image](#updating-the-docker-image)
- [Troubleshooting](#troubleshooting)
  - [Running as root](#running-as-root)
- [Image Tagging Strategy](#image-tagging-strategy)
- [License](#license)
- [Contributing](#contributing)

## Prerequisites

Before you begin, ensure you have the necessary tools installed.

### For Using the Image

- [Docker](https://www.docker.com/get-started)
- Docker Compose (if using Option 3, typically included with Docker Desktop)
- [Gemini API Key](https://aistudio.google.com/app/apikey) (recommended, but optional for VS Code Dev Containers)

## Image Variants

This image comes in three main variants to suit different use cases.

### `gemini-cli:<version>-node`

The `node` variant is based on the Node.js [Docker Official Image](https://hub.docker.com/_/node). It is focused on providing a minimal environment to run `gemini-cli`, making it lightweight.

- **Recommended Use:** For running `gemini-cli` commands with `docker run` or `docker-compose`.

### `gemini-cli:<version>-javascript-node`

The `javascript-node` variant is based on the [Microsoft Dev Containers `javascript-node` image](https://github.com/devcontainers/templates/tree/main/src/javascript-node). It includes common development tools like `git` and `zsh` for JavaScript development.

- **Recommended Use:** As a development environment in VS Code Dev Containers for JavaScript projects.

### `gemini-cli:<version>-typescript-node`

The `typescript-node` variant is based on the [Microsoft Dev Containers `typescript-node` image](https://github.com/devcontainers/templates/tree/main/src/typescript-node). In addition to the tools in `javascript-node`, it includes TypeScript-specific tools and provides a richer development environment.

- **Recommended Use:** As a development environment in VS Code Dev Containers for TypeScript projects.

## Initial Setup

Before using any of the options below, you'll need to perform these one-time setup steps in your project's root directory.

1. **Create a `.env` file for your Gemini API key (Recommended):** Create a `.env` file to keep your API key separate from your code. This step is optional if you are authenticating via a browser in the VS Code Dev Container.

    **.env**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY_HERE
    ```

2. **Create a directory for user data:** This directory will persist Gemini CLI's user-specific data, such as authentication details and command history.

    ```bash
    mkdir -p .gemini_user
    ```

> **Note:** It is recommended to add both `.env` and `.gemini_user` to your `.gitignore` file to prevent your credentials and settings from being checked into version control.

## How to Use This Image

After completing the Initial Setup, choose one of the following options.

### Option 1: Start an Interactive Shell Session

This is the most common way to use the image. It starts a shell inside the container, allowing you to run `gemini` commands.

```bash
docker run -it --rm \
  # Pass the API key from the .env file
  --env-file .env \
  # Mount your project directory
  -v "$(pwd):/workspace" \
  # Set the working directory inside the container
  -w "/workspace" \
  # Mount a volume to persist user data
  -v "$(pwd)/.gemini_user:/home/node/.gemini" \
  # Specify the image to run
  naoyoshinori/gemini-cli:0.1-node
```

Once inside the container, run `gemini` to use the tool.

### Option 2: Run a Single Command

You can also execute a single command without starting an interactive shell.

```bash
docker run -it --rm \
  --env-file .env \
  -v "$(pwd):/workspace" -w "/workspace" \
  -v "$(pwd)/.gemini_user:/home/node/.gemini" \
  naoyoshinori/gemini-cli:0.1-node \
  gemini
```

### Option 3: Use with `docker-compose`

Using `docker-compose` is a convenient way to manage the container declaratively.

Create a `docker-compose.yaml` file with the following content. It will automatically load the `GEMINI_API_KEY` from your `.env` file.

**docker-compose.yaml**

```yaml
services:
  gemini-cli:
    image: naoyoshinori/gemini-cli:0.1-node
    working_dir: /workspace
    environment:
      - GEMINI_API_KEY=${GEMINI_API_KEY}
    volumes:
      - .:/workspace:cached
      - ./.gemini_user:/home/node/.gemini:cached
    command: ["sleep", "infinity"]
```

Then, start and use the environment:

Start the container in the background

```bash
docker-compose up -d
```

Run gemini in interactive mode

```bash
docker-compose exec gemini-cli gemini
```

Stop and remove the container when you're done

```bash
docker-compose down
```

### Option 4: Use as a VS Code Dev Container

The `javascript-node` and `typescript-node` variants are designed for use as a VS Code Dev Container, providing a consistent development environment.

**Authentication:** You have two options for authentication:

1. **Using an API Key (Recommended):** Follow the steps in the [Initial Setup](#initial-setup) to create a `.env` file. VS Code will automatically make the `GEMINI_API_KEY` available within the container.

2. **Interactive Browser-based Authentication:** If you omit the `.env` file, you can authenticate interactively. The first time you run a `gemini` command in the container's terminal, you will be prompted to open a URL in your local browser to sign in. VS Code's port forwarding handles this process seamlessly.

Create a `.devcontainer/devcontainer.json` file in your project's root with the following content. Choose the image that best fits your project (`javascript-node` or `typescript-node`).

**`.devcontainer/devcontainer.json`**

```json
{
  "name": "Gemini CLI Dev Container",
  "image": "naoyoshinori/gemini-cli:0.1-javascript-node",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached",
  "mounts": [
    "source=${localWorkspaceFolder}/.gemini_user,target=/home/node/.gemini,type=bind,consistency=cached"
  ],
  "workspaceFolder": "/workspace",
  "remoteUser": "node"
}
```

After creating the file, open your project in VS Code and use the "Reopen in Container" command.

### Updating the Docker Image

To ensure you are using the latest version of the Docker image, pull the updated image from Docker Hub:

```bash
docker pull naoyoshinori/gemini-cli:0.1-node
```

## Troubleshooting

### Running as root

In some cases, you might need root privileges inside the container, for example to resolve permission errors with files mounted from the host.

If you require root access, you can try the following modifications.

#### For `docker-compose`

To run the `docker-compose` service as root, add `user: root` to the service definition and update the volume path for the `.gemini` directory.

**docker-compose.yaml**

```yaml
services:
  gemini-cli:
    image: naoyoshinori/gemini-cli:0.1-node
    user: root
    working_dir: /workspace
    environment:
      - GEMINI_API_KEY=${GEMINI_API_KEY}
    volumes:
      - .:/workspace:cached
      - ./.gemini_user:/root/.gemini:cached # Note the path change to /root/.gemini
    command: ["sleep", "infinity"]
```

#### For VS Code Dev Containers

To run as the `root` user in a Dev Container, modify your `.devcontainer/devcontainer.json` to set `remoteUser` to `"root"` and adjust the volume mount for Gemini's configuration.

**`.devcontainer/devcontainer.json`**

```json
{
  "name": "Gemini CLI Dev Container",
  "image": "naoyoshinori/gemini-cli:0.1-javascript-node",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached",
  "mounts": [
    "source=${localWorkspaceFolder}/.gemini_user,target=/root/.gemini,type=bind,consistency=cached"
  ],
  "workspaceFolder": "/workspace",
  "remoteUser": "root"
}
```

## Image Tagging Strategy

Tags for [`naoyoshinori/gemini-cli`](https://hub.docker.com/r/naoyoshinori/gemini-cli) are structured to clearly indicate their version, base type, and specific variant. **The `latest` tag is not used.** You should always specify a tag that includes a version number to ensure reproducibility.

**Format:** `<image>:<version>-<base_type>-<variant>`

- **`<version>`**: The version of the Gemini CLI (e.g., `0.1`).
- **`<base_type>`**: The image's base type (e.g., `node`, `javascript-node`, `typescript-node`).
- **`<variant>`**: The specific Node.js version and OS combination (e.g., `22-bookworm-slim`, `22-bookworm`).

### Main Tags

For everyday use and development, we recommend the following main tags:

- `naoyoshinori/gemini-cli:0.1-node`
- `naoyoshinori/gemini-cli:0.1-javascript-node`
- `naoyoshinori/gemini-cli:0.1-typescript-node`

These main tags omit the `<variant>` part, indicating the default or recommended Node.js version and OS for that base type.

### Fully-Qualified Tags for Reproducibility

A tag that includes the specific Node.js version and OS, such as `naoyoshinori/gemini-cli:0.1-javascript-node-22-bookworm`, is called a "fully-qualified tag." These tags point to a specific, immutable build.

**It is highly recommended to use these fully-qualified tags for CI/CD pipelines or any production-like environment where reproducibility is critical.**

## License

- The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
- The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
- As with all Docker images, this image also contains other software under other licenses (e.g., the base OS distribution and its dependencies).

## Contributing

Interested in contributing to this project? See [CONTRIBUTING.md](CONTRIBUTING.md) for details.
