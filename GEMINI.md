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
  - `src/<variant>/build.conf`: Configuration file read by build/release scripts, defining the base `IMAGE` and `VARIANT` (e.g., `IMAGE="node"`, `VARIANT="22-bookworm-slim"`).
  - `src/<variant>/version.txt`: Automatically updated with the installed `@google/gemini-cli` version when `build.sh` is executed.

- **Available Image Variants**:
  - `node`: A minimal image based on `node:<version>-slim`.
  - `javascript-node`: A development-oriented image based on `mcr.microsoft.com/devcontainers/javascript-node`.
  - `typescript-node`: A richer development-oriented image based on `mcr.microsoft.com/devcontainers/typescript-node`.

### 2.2. Automation Scripts

- `build.sh <variant>`: Builds the specified Docker image variant. It reads `src/<variant>/build.conf` and the root `.env.docker` file. After building, it retrieves the CLI version and updates `version.txt`.
- `release.sh <variant>`: Pushes the built image to the Docker registry defined in `.env.docker`.
- `build_all.sh` / `release_all.sh`: Wrapper scripts to execute build/release processes for all variants.

### 2.3. Configuration and Execution

- `.env.docker`: **Required for build and release**. Contains Docker registry credentials (`IMAGE_REGISTRY`, `DOCKER_REGISTRY_USER`, `DOCKER_REGISTRY_PASSWORD`).
- `docker-compose.yaml`: Defines the `gemini-cli` service for development and usage purposes.
- `.devcontainer/devcontainer.json`: Configuration file for opening the project in VS Code Dev Containers, primarily using `javascript-node` or `typescript-node` variants.

## 3. Gemini Assistant Workflows

### 3.1. Interaction Modes

The Gemini Assistant operates in two primary interaction modes:

- **Plan Mode (Default)**: By default, the assistant operates in "plan mode." In this mode, it focuses on understanding user requests, formulating a detailed plan of action, and presenting this plan for review. The assistant will wait for explicit user confirmation before proceeding with any implementation.
- **Act Mode**: To execute a proposed plan, the user must explicitly type "act." Upon receiving this command, the assistant will proceed with the implementation steps outlined in the most recent plan.
- **Revisiting Plans**: If the user wishes to revise, modify, or create a new plan, they can type "plan." This will prompt the assistant to re-enter the planning phase.
- **Direct Commands**: Single, clear actions (e.g., reading a file, executing a shell command) provided directly by the user will be executed immediately without entering a planning phase, as these are considered direct "act" instructions.
- **File Deletion**: If the assistant determines that a file needs to be deleted during a task, it will always ask for explicit user confirmation before proceeding with the deletion.

### 3.2. Coding Workflow

The Gemini Assistant performs coding tasks for the project following this workflow:

1. **Understand**: Comprehend user requirements and relevant codebase context. Extensively use `search_file_content` and `glob` tools to grasp file structures, existing code patterns, and conventions. Use `read_file` and `read_many_files` to understand context and validate assumptions.
2. **Plan**: Develop a coherent plan to address the user's task, grounded in the understanding from step 1. Incorporate self-verification loops, such as writing unit tests, as needed.
3. **Implement**: Apply changes using available tools (e.g., `replace`, `write_file`, `run_shell_command`) based on the plan, strictly adhering to established project conventions.
4. **Verify (Tests)**: Where applicable, verify changes using the project's testing procedures. Identify correct test commands and frameworks from `README` files, build/package configurations, or existing test execution patterns.
5. **Verify (Standards)**: After code modifications, execute project-specific build, linting, and type-checking commands (e.g., `tsc`, `npm run lint`, `ruff check .`) to ensure code quality and adherence to standards.
6. **Commit Changes**: When requested to commit changes, the assistant will only commit files that have been explicitly staged by the user (i.e., added to the Git staging area). The user is responsible for controlling which files are staged for commit. The assistant will propose a draft commit message for user review.

### 3.3. Documentation Workflow

The Gemini Assistant performs documentation tasks for the project following this workflow:

1. **Understand**: Comprehend user documentation requests and the context of existing relevant documentation.
2. **Plan**: Develop a plan considering the document's structure, content, and target audience.
3. **Create/Update**: Create or update documentation using `write_file` or `replace` tools based on the plan, aligning with existing document styles and formats.
4. **Review**: Confirm that the created/updated documentation is accurate, clear, and reflects the user's intent.

## 4. Utilizing the Gemini CLI

The `gemini-cli` service can be developed and utilized in the following ways:

- **Docker Compose**: Start the service using the `docker-compose.yaml` file.

    ```bash
    docker-compose up -d gemini-cli
    ```

    Then, you can execute the CLI with `docker-compose exec gemini-cli gemini`.
- **VS Code Dev Container**: Open the project in a VS Code Dev Container using the `.devcontainer/devcontainer.json` configuration file. This provides an integrated development environment for using the CLI.
- **Direct Docker Execution**: Run the built image directly using the `docker run` command.

    ```bash
    docker run --rm <your-registry>/gemini-cli:<variant-tag> gemini
    ```

For detailed usage instructions, please refer to `README.md` and relevant documentation within the `docs/` directory.
