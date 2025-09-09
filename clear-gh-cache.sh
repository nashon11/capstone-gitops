#!/bin/bash

# This script helps clear GitHub Actions caches and force a new workflow run

# Delete all workflow runs
gh run list --workflow=kubernetes-scan.yaml --json databaseId -q ".data[].databaseId" | xargs -I{} gh run delete {}

# Clear the Actions cache
gh api -X DELETE /repos/nashon11/capstone-gitops/actions/caches --jq '.message'

# Trigger a new workflow run
gh workflow run kubernetes-scan.yaml

echo "✅ Cache cleared and new workflow triggered. Check GitHub Actions for progress."
