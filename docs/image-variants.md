# Image Variants

This project offers three main image variants, each designed for a different use case. This document details the available image variants to help you choose the best one for your needs.

## Recommended Tags

For most users, we recommend using one of the following tags. These point to the latest stable version of their respective base images.

* `naoyoshinori/gemini-cli:0-node` (or `0-node-24-bookworm⁠`, `0-node-24-bookworm-slim`, `0-node-22-bookworm⁠`, `0-node-22-bookworm-slim`)
* `naoyoshinori/gemini-cli:0-javascript-node` (or `0-javascript-node-24-bookworm⁠⁠`, `0-javascript-node-22-bookworm`)
* `naoyoshinori/gemini-cli:0-typescript-node` (or `0-typescript-node-24-bookworm⁠`, `0-typescript-node-22-bookworm⁠`)

## Variant Details

### `node` Variant

Based on the [Node.js Docker Official Image](https://hub.docker.com/_/node), this is a minimal, lightweight image for running the Gemini CLI.

* **Best for:**
  * Running Gemini CLI commands directly.
  * Integration into scripts or CI/CD pipelines.
  * Pure execution environments that do not require development tools.

### `javascript-node` Variant

Based on the [Microsoft Dev Containers `javascript-node` image](https://github.com/devcontainers/templates/tree/main/src/javascript-node), this variant includes common development tools like `git` and `zsh`.

* **Best for:**
  * Use as a development environment in VS Code Dev Containers.
  * Situations where you need Git or other shell tools alongside the Gemini CLI.

### `typescript-node` Variant

Based on the [Microsoft Dev Containers `typescript-node` image](https://github.com/devcontainers/templates/tree/main/src/typescript-node), this adds TypeScript-specific tools on top of the `javascript-node` variant.

* **Best for:**
  * Use as a development environment for TypeScript projects.
  * Situations where you want to perform type-checking and linting while using the CLI.

## About Image Tags

All image tags follow the format below. Please note that a `latest` tag is not provided to encourage deliberate version selection.

**Tag Format:** `<version>-<base_image>` or `<version>-<base_image>-<base_image_variant>`

* **`<version>`**: The version of the Gemini CLI (e.g., `0`, `0.x`).
* **`<base_image>`**: The base image name (`node`, `javascript-node`, or `typescript-node`).
* **`<base_image_variant>`** (Optional): A variant tag from the base image, which typically specifies the Node.js version and OS (e.g., `24-bookworm`, `22-bookworm`).

If you need to lock to a specific version for maximum reproducibility (e.g., in CI/CD), you can use a **"fully-qualified tag"** which includes the `<base_image_variant>`, such as `0-javascript-node-24-bookworm`.

---

[Documentation Home](./index.md)
