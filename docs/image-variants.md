# Image Variants

This image comes in three main variants to suit different use cases.

## `gemini-cli:<version>-node`

The `node` variant is based on the Node.js [Docker Official Image](https://hub.docker.com/_/node). It is focused on providing a minimal environment to run `gemini-cli`, making it lightweight.

* **Example Tag:** `naoyoshinori/gemini-cli:0.1-node`
* **Recommended Use:**
  * For running `gemini-cli` commands directly from the command line.
  * For integration into scripts or CI/CD pipelines.
  * When you only need a pure execution environment without development tools.

## `gemini-cli:<version>-javascript-node`

The `javascript-node` variant is based on the [Microsoft Dev Containers `javascript-node` image](https://github.com/devcontainers/templates/tree/main/src/javascript-node). It includes common development tools like `git` and `zsh` for JavaScript development.

* **Example Tag:** `naoyoshinori/gemini-cli:0.1-javascript-node`
* **Recommended Use:**
  * As a development environment in VS Code Dev Containers for JavaScript projects.
  * When you need to perform Git operations or use other command-line tools in the same environment while working with `gemini-cli`.

## `gemini-cli:<version>-typescript-node`

The `typescript-node` variant is based on the [Microsoft Dev Containers `typescript-node` image](https://github.com/devcontainers/templates/tree/main/src/typescript-node). In addition to the tools in `javascript-node`, it includes TypeScript-specific tools and provides a richer development environment.

* **Example Tag:** `naoyoshinori/gemini-cli:0.1-typescript-node`
* **Recommended Use:**
  * As a development environment in VS Code Dev Containers for TypeScript projects.
  * When you want to develop with `gemini-cli` while performing type checking and linting in your TypeScript project.
