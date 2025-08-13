---
document_language: English
codebase_language: English
assistant_interaction_language: Japanese
---
# Project Overview for Gemini Assistant: Docker for Gemini CLI

## 1. Core Functionality

This repository provides a set of Dockerfiles, configuration files, and scripts for building and distributing Docker images to run `@google/gemini-cli`. The primary goal is to create a consistent and easy-to-use execution environment for the Gemini CLI.

## 2. Project Structure and Key Files

### 2.1. Image Variants

- `src/`: Contains the source code for Docker images, organized by variant.
  - `src/<variant>/Dockerfile`: Defines the build for each image variant.

- **Available Image Variants**:
  - `node`: A minimal image based on `node:<version>-slim`.
  - `javascript-node`: A development-oriented image based on `mcr.microsoft.com/devcontainers/javascript-node`.
  - `typescript-node`: A richer development-oriented image based on `mcr.microsoft.com/devcontainers/typescript-node`.

### 2.2. Automation

Build and release processes are automated using GitHub Actions. The workflow is defined in `.github/workflows/release.yml`.

## 3. Documentation

User-facing documentation is located in the `docs/` directory.
