# GitHub Actions

## Overview

GitHub Actions enables automation of software workflows, such as building, testing, and deploying code directly from your GitHub repository.

## What is Continuous Integration (CI)?

Continuous Integration (CI) automatically checks code quality and runs tests on every push to specified branches (e.g., `main`). This helps catch issues early and ensures code consistency across the application.

## What is Continuous Delivery/Deployment (CD)?

Continuous Delivery/Deployment (CD) ensures your code is always in a deployable state. It tests deployments to environments similar to production, helping verify that new changes can be safely released.

## Prerequisites

- A GitHub repository
- Basic knowledge of YAML syntax
- Access to repository settings for configuring Actions

## Usage

1. Create a workflow file in `.github/workflows/` (e.g., `ci.yml`)
2. Define jobs for build, test, and deploy steps using YAML
3. Push changes to trigger workflows automatically

## Workflow Architecture

```
                        GitHub Actions Flow

┌─────────────────────────────────────────────────────────┐
│                    Event Triggers                      │
│                                                        │
│    push  •  pull_request  •  schedule  •  manual       │
└────────────────────────┬────────────────────────────────┘
                         │ Triggers workflow
                         ▼
┌─────────────────────────────────────────────────────────┐
│                   Workflow Files                       │
│                                                        │
│         Location: .github/workflows/*.yml              │
│         Defines: jobs, runners, steps                  │
└────────────────────────┬────────────────────────────────┘
                         │ Contains
                         ▼
┌─────────────────────────────────────────────────────────┐
│                        Jobs                            │
│                                                        │
│    • Run on: ubuntu-latest, windows, macos             │
│    • Execute: in parallel or sequence                  │
│    • Access: secrets, environment variables            │
└────────────────────────┬────────────────────────────────┘
                         │ Composed of
                         ▼
┌─────────────────────────────────────────────────────────┐
│                       Steps                            │
│                                                        │
│    • Use actions: checkout, setup-node                 │
│    • Run commands: npm install, npm test               │
│    • Conditional: if success/failure                   │
└─────────────────────────────────────────────────────────┘
```

## Example Workflow

```yaml
name: Star event workflow

on:
  watch: # This event is triggered when a repository is starred or unstarred

jobs:
  log-star-event:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Log star event
        run: |
          echo "A user has starred or unstarred the repository"
          echo "Event information:"
          cat $GITHUB_EVENT_PATH
```

## Common Workflow Examples

### CI/CD Pipeline

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "18"

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build application
        run: npm run build
```

## Key Concepts

### Runners

Runners are the servers that execute your workflow jobs. GitHub provides hosted runners for:

- `ubuntu-latest` (Linux)
- `windows-latest` (Windows)
- `macos-latest` (macOS)

### Actions

Actions are reusable units of code that can be shared across workflows. Popular actions include:

- `actions/checkout`: Checks out your repository code
- `actions/setup-node`: Sets up Node.js environment
- `actions/cache`: Caches dependencies for faster builds

### Secrets

Secrets are encrypted environment variables used to store sensitive information like API keys and passwords. Access them in workflows using:

```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
```

### Artifacts

Artifacts are files produced by a workflow that you can download or use in other jobs:

```yaml
- name: Upload artifact
  uses: actions/upload-artifact@v3
  with:
    name: build-files
    path: dist/
```
