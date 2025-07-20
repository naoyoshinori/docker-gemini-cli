# Docker for Gemini CLI

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A ready-to-use, secure, and convenient Docker environment for [Google's Gemini CLI](https://github.com/google-gemini/gemini-cli) (`@google/gemini-cli`).

[This project](https://github.com/naoyoshinori/docker-gemini-cli) provides Docker images that let you use the Gemini CLI without installing Node.js on your system. It's designed for security and ease of use, running as a non-root user and offering seamless integration with VS Code Dev Containers. Two main variants are offered to suit different needs: a minimal image for direct execution and a feature-rich image for development.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Image Variants](#image-variants)
  - [`gemini-cli:<version>-node`](#gemini-cliversion-node)
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
- [Contributing to This Project](#contributing-to-this-project)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Open in Dev Container](#step-2-open-in-dev-container)
  - [Step 3: Configure Your Environment](#step-3-configure-your-environment)
  - [Step 4: Build, Release, and Update](#step-4-build-release-and-update)
  - [Updating the Gemini CLI Package](#updating-the-gemini-cli-package)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the necessary tools installed.

### For Using the Image

- [Docker](https://www.docker.com/get-started)
- Docker Compose (if using Option 3, typically included with Docker Desktop)
- [Gemini API Key](https://aistudio.google.com/app/apikey) (recommended, but optional for VS Code Dev Containers)

#### For Contributing

- [Git](https://git-scm.com/downloads/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code

## Image Variants

This image comes in two main variants to suit different use cases.

### `gemini-cli:<version>-node`

The `node` variant is based on the Node.js [Docker Official Image](https://hub.docker.com/_/node). It is focused on providing a minimal environment to run `gemini-cli`, making it lightweight.

- **Recommended Use:** For running `gemini-cli` commands with `docker run` or `docker-compose`.

### `gemini-cli:<version>-typescript-node`

The `typescript-node` variant is based on the [Microsoft Dev Containers `typescript-node` image](https://github.com/devcontainers/templates/tree/main/src/typescript-node). In addition to `gemini-cli`, it includes common development tools like `git`, `zsh`, and `sudo`, providing a richer development environment.

- **Recommended Use:** As a development environment in VS Code Dev Containers. It's useful when you need to run `git` commands or install additional packages inside the container.

## Initial Setup

Before using any of the options below, you'll need to perform these one-time setup steps in your project's root directory.

1. **Create a `.env` file for your API key (Recommended):** To keep your API key secure, create a `.env` file. This step is optional for the VS Code Dev Container method if you prefer to authenticate via a browser.

    **.env**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY_HERE
    ```

2. **Create a directory for user data:** This directory will persist Gemini CLI's user-specific data, such as authentication details and command history.

    ```bash
    mkdir -p .gemini_user
    ```

> **Note:** It is strongly recommended to add both `.env` and `.gemini_user` to your `.gitignore` file to prevent your credentials and settings from being checked into version control.

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
      - .:/workspace
      - ./.gemini_user:/home/node/.gemini
    command: ["sleep", "infinity"]
```

Then, start and use the environment:

```bash
# Start the container in the background
docker-compose up -d

# Run gemini in interactive mode
docker-compose exec gemini-cli gemini

# Stop and remove the container when you're done
docker-compose down
```

### Option 4: Use as a VS Code Dev Container

Using the `typescript-node` variant as a development environment is highly recommended for an integrated experience.

**Authentication:** You have two options for authentication:

1. **Using an API Key (Recommended):** Follow the steps in the [Initial Setup](#initial-setup) to create a `.env` file. VS Code will automatically make the `GEMINI_API_KEY` available within the container.

2. **Interactive Browser-based Authentication:** If you omit the `.env` file, you can authenticate interactively. The first time you run a `gemini` command in the container's terminal, you will be prompted to open a URL in your local browser to sign in. VS Code's port forwarding handles this process seamlessly.

Create a `.devcontainer/devcontainer.json` file in your project's root with the following content:

**`.devcontainer/devcontainer.json`**

```json
{
  "name": "Gemini CLI Dev Container",
  "image": "naoyoshinori/gemini-cli:0.1-typescript-node",
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

In some cases, you might need root privileges inside the container. This can be necessary to resolve permission errors, especially with files mounted from the host, or to install system-level packages using `apt`. For these scenarios, it is recommended to use the `typescript-node` variant, which includes `sudo`.

#### For VS Code Dev Containers

To run as the `root` user in a Dev Container, modify your `.devcontainer/devcontainer.json` to set `remoteUser` to `"root"` and adjust the volume mount for Gemini's configuration.

**`.devcontainer/devcontainer.json`**

```json
{
  "name": "Gemini CLI Dev Container",
  "image": "naoyoshinori/gemini-cli:0.1-typescript-node",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached",
  "mounts": [
    "source=${localWorkspaceFolder}/.gemini_user,target=/root/.gemini,type=bind,consistency=cached"
  ],
  "workspaceFolder": "/workspace",
  "remoteUser": "root"
}
```

#### For `docker-compose`

To run the `docker-compose` service as root, add `user: root` to the service definition and update the volume path for the `.gemini` directory.

**docker-compose.yaml**

```yaml
services:
  gemini-cli:
    image: naoyoshinori/gemini-cli:0.1-typescript-node
    user: root
    working_dir: /workspace
    environment:
      - GEMINI_API_KEY=${GEMINI_API_KEY}
    volumes:
      - .:/workspace
      - ./.gemini_user:/root/.gemini # Note the path change to /root/.gemini
    command: ["sleep", "infinity"]
```

## Image Tagging Strategy

Tags for [`naoyoshinori/gemini-cli`](https://hub.docker.com/r/naoyoshinori/gemini-cli) are structured to clearly indicate their version and variant. **The `latest` tag is not used.** You should always specify a tag that includes a version number to ensure reproducibility.

**Format:** `<image>:<version>-<variant>-<base_version>-<os>`

- **`<version>`**: The version of the Gemini CLI (e.g., `0.1`).
- **`<variant>`**: The image variant (e.g., `node`, `typescript-node`).
- **`<base_version>`**: The underlying Node.js version (e.g., `22`, `1-22`).
- **`<os>`**: The base image's OS (e.g., `bookworm-slim`, `bookworm`).

### Main Tags

For everyday use and development, we recommend the following main tags:

- `naoyoshinori/gemini-cli:0.1-node`
- `naoyoshinori/gemini-cli:0.1-typescript-node`

### Fully-Qualified Tags for Reproducibility

A tag that includes the OS version, such as `naoyoshinori/gemini-cli:0.1-typescript-node-1-22-bookworm`, is called a "fully-qualified tag." These tags point to a specific, immutable build.

**It is highly recommended to use these fully-qualified tags for CI/CD pipelines or any production-like environment where reproducibility is critical.**

## Contributing to This Project

Interested in improving this Docker image? A Docker-in-Docker development environment is ready for you.

### Step 1: Clone the Repository

First, get a local copy of this project.

```bash
git clone https://github.com/naoyoshinori/docker-gemini-cli.git
cd docker-gemini-cli
```

### Step 2: Open in Dev Container

Open the cloned repository folder in VS Code. When prompted, click **"Reopen in Container"**. This will launch a development environment where you can safely build and test changes without affecting your local Docker setup.

### Step 3: Configure Your Environment

Before you can build or release images, you must create a `.env` file in the project root to specify your Docker registry credentials.

```env
# .env
IMAGE_REGISTRY=your_docker_registry # e.g., docker.io or ghcr.io
DOCKER_REGISTRY_USER=your_docker_registry_username
DOCKER_REGISTRY_PASSWORD=your_docker_registry_password_or_token
```

### Step 4: Build, Release, and Update

After configuring your `.env` file, you can use the following scripts.

#### Build the Image

Run the build script to create the Docker images on your local machine.

```bash
chmod +x build.sh

# To build the minimal 'node' variant
./build.sh node

# To build the feature-rich 'typescript-node' variant
./build.sh typescript-node
```

#### Release the Image

Run the release script to push the built images to your Docker registry.

```bash
chmod +x release.sh

# To release the 'node' variant
./release.sh node

# To release the 'typescript-node' variant
./release.sh typescript-node
```

### Updating the Gemini CLI Package

To update the `@google/gemini-cli` package to the latest version, run the update script. This will reset and re-initialize `package.json` and `package-lock.json`.

```bash
chmod +x update.sh
./update.sh
```

After the script finishes, run the build and release scripts again to publish a new version.

## License

- The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
- The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
- As with all Docker images, this image also contains other software under other licenses (e.g., the base OS distribution and its dependencies).
