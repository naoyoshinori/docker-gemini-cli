# Contributing to Docker for Gemini CLI

Thank you for your interest in this project! This document provides guidelines for contributing to the project through bug reports, feature suggestions, and code contributions.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Contributing to This Project](#contributing-to-this-project)
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)
  - [Step 2: Open in Dev Container](#step-2-open-in-dev-container)
  - [Step 3: Configure Your Environment](#step-3-configure-your-environment)
  - [Step 4: Build, Release, and Update](#step-4-build-release-and-update)
    - [Build the Image](#build-the-image)
    - [Release the Image](#release-the-image)
- [License](#license)
- [Usage Information](#usage-information)

## Prerequisites

Before you start contributing, make sure you have the following tools installed:

- [Git](https://git-scm.com/downloads/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code

## Contributing to This Project

A Docker-in-Docker development environment is provided, allowing for safe development.

### Step 1: Clone the Repository

First, clone this project locally.

```bash
git clone https://github.com/naoyoshinori/docker-gemini-cli.git
cd docker-gemini-cli
```

### Step 2: Open in Dev Container

Open the cloned repository folder in VS Code. When prompted, click **"Reopen in Container"**. This will launch a development environment where you can safely build and test your changes without affecting your local Docker setup.

### Step 3: Configure Your Environment

Before building or releasing images, you need to create a `.env.docker` file at the root of your project to specify your Docker registry credentials **for pushing images**.

**.env.docker**

```env
IMAGE_REGISTRY=your-docker-registry # e.g., docker.io or ghcr.io
DOCKER_REGISTRY_USER=your-dockerhub-username
DOCKER_REGISTRY_PASSWORD=your-dockerhub-access-token
```

### Step 4: Build and Release Images

After configuring your `.env.docker` file, you can use the following scripts:

#### Build the Image

Run the build script to create the Docker image on your local machine.

```bash
chmod +x build.sh
```

Build the minimal 'node' variant

```bash
./build.sh node
```

Build the 'javascript-node' variant

```bash
./build.sh javascript-node
```

Build the feature-rich 'typescript-node' variant

```bash
./build.sh typescript-node
```

To build all variants at once, use the `build_all.sh` script:

```bash
chmod +x build_all.sh
./build_all.sh
```

#### Release the Image

Run the release script to push your built image to your Docker registry.

```bash
chmod +x release.sh
```

Release the 'node' variant

```bash
./release.sh node
```

Release the 'javascript-node' variant

```bash
./release.sh javascript-node
```

Release the 'typescript-node' variant

```bash
./release.sh typescript-node
```

To release all variants at once, use the `release_all.sh` script:

```bash
chmod +x release_all.sh
./release_all.sh
```

## License

- The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
- The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
- As with all Docker images, this image also contains other software under other licenses (e.g., the base OS distribution and its dependencies).

## Usage Information

For general usage information about this Docker image, please refer to the [README.md](README.md).
