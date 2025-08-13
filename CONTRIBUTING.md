# Contributing to Docker for Gemini CLI

Thank you for your interest in this project! This document provides guidelines for contributing to the project through bug reports, feature suggestions, and code contributions.

## Prerequisites

Before you start contributing, make sure you have the following tools installed:

- [Git](https://git-scm.com/downloads/)
- [Docker](https://docs.docker.com/get-docker/)

## Development

This project provides a `docker-compose.yaml` file for a consistent development environment.

1. **Clone the repository:**

    ```bash
    git clone https://github.com/naoyoshinori/docker-gemini-cli.git
    cd docker-gemini-cli
    ```

2. **Start the development container:**

    ```bash
    docker-compose up -d
    ```

    This will start a container with the `gemini-cli` service.

3. **Access the `gemini-cli`:**
    You can execute commands in the running container:

    ```bash
    docker-compose exec gemini-cli gemini --help
    ```

## Project Structure

- `src/`: Contains the Dockerfiles for the different image variants.
  - `src/<variant>/Dockerfile`: The Dockerfile for a specific variant (e.g., `node`, `javascript-node`).
- `.github/workflows/release.yml`: The GitHub Actions workflow for building and releasing the Docker images.
- `docker-compose.yaml`: Defines the `gemini-cli` service for development.
- `docs/`: Contains the documentation for the project.
- `GEMINI.md`: Provides an overview of the project for the Gemini assistant.

## Build and Release Process

The build and release process for the Docker images is automated using GitHub Actions. The workflow is defined in `.github/workflows/release.yml`.

The workflow is triggered by:

- A schedule (twice a day).
- A push to the `main` branch.
- A manual trigger.

The workflow automatically builds and pushes the Docker images to the Docker registry. It also checks for new versions of the `@google/gemini-cli` package and the base images to determine if a new build is needed.

## License

- The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
- The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
- As with all Docker images, this image also contains other software under other licenses (e.g., the base OS distribution and its dependencies).

## Usage Information

For general usage information about this Docker image, please refer to the [README.md](README.md).
