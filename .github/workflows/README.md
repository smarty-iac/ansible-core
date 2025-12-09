# GitHub Actions Workflows

## Overview

This repository contains automated workflows for building and managing Docker images with different ansible-core versions.

## Workflows

### 1. Build and Push Docker Image (`docker-image.yml`)

**Triggers:**
- **Tag Push:** When you push a tag matching `*-smarty*` pattern
- **Weekly Schedule:** Every Sunday at midnight UTC (auto-builds latest ansible-core)
- **Manual Dispatch:** Trigger manually via GitHub Actions UI with optional version input

**Features:**
- ✅ Validates ansible-core version exists on PyPI before building
- ✅ Automatically fetches latest ansible-core version for scheduled/manual builds
- ✅ Creates multiple image tags:
  - Full version: `2.20.0-smarty1.3`
  - Enrichment tag: `smarty1.3`
  - Major.minor latest: `2.20-latest`
  - Overall latest: `latest`
- ✅ Timestamp-based tags for auto-builds: `2.20.0-smarty-auto-20251209`

**Usage:**

```bash
# Manual tag-based build
git tag 2.20.0-smarty1.4
git push origin 2.20.0-smarty1.4

# Or trigger manually in GitHub Actions UI
# Go to Actions → Build and Push Docker Image → Run workflow
# Optionally specify ansible version or leave empty for latest
```

### 2. Check for New Ansible Version (`version-check.yml`)

**Triggers:**
- **Weekly Schedule:** Every Monday at noon UTC
- **Manual Dispatch:** Trigger manually via GitHub Actions UI

**Features:**
- ✅ Checks PyPI for new ansible-core releases
- ✅ Compares with current latest tag in repository
- ✅ Automatically creates GitHub issue when new version is detected
- ✅ Prevents duplicate issues with smart checking

**Behavior:**
When a new ansible-core version is found, it creates an issue with:
- Current vs. new version comparison
- Instructions for updating
- Direct link to PyPI release

## Tag Naming Convention

Tags follow this pattern: `<ansible-version>-smarty<enrichment-version>`

Examples:
- `2.20.0-smarty1.4` - Ansible 2.20.0 with custom enrichment version 1.4
- `2.19.4-smarty2.0` - Ansible 2.19.4 with custom enrichment version 2.0

Auto-generated tags (from scheduled builds):
- `2.20.0-smarty-auto-20251209` - Built on Dec 9, 2025

## Docker Image Tags

Each build creates multiple tags on `ghcr.io`:

| Tag Pattern | Example | Description |
|-------------|---------|-------------|
| `<full-version>` | `2.20.0-smarty1.4` | Specific version + enrichment |
| `<enrichment-tag>` | `smarty1.4` | Just the enrichment identifier |
| `<major>.<minor>-latest` | `2.20-latest` | Latest for major.minor series |
| `latest` | `latest` | Most recent build |

## Automatic Updates

The workflow system provides three levels of automation:

1. **Passive Monitoring** - Weekly version checks create issues
2. **Semi-Automatic** - Weekly builds of latest version (every Sunday)
3. **Manual Override** - Trigger builds anytime with any version

## Requirements

- Repository secret `GITHUB_TOKEN` (automatically available)
- Docker Buildx support (provided by ubuntu-latest runners)
- `jq` for JSON parsing (pre-installed on GitHub runners)
