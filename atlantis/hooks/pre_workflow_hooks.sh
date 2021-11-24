#!/bin/bash

set -euo pipefail

# https://www.runatlantis.io/docs/pre-workflow-hooks.html
echo "start pre_workflow_hooks"

# Check if a pull request contains migration file.
# This example assumes the following:
# - You are using GitHub.
# - Migration files are stored in `tfmigrate/` directory.
# - A number of changed files less than 100 without pagination.
# https://docs.github.com/en/rest/reference/pulls#list-pull-requests-files
MIGRATION_FILES=$(curl -sS \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token ${ATLANTIS_GH_TOKEN}" \
  "https://api.github.com/repos/${BASE_REPO_OWNER}/${BASE_REPO_NAME}/pulls/${PULL_NUM}/files?per_page=100" \
 | jq -r '.[] | select(.filename | startswith("tfmigrate/")) | .filename')
echo "MIGRATION_FILES: $MIGRATION_FILES"

# If it contains a migration, generate a project with `tfmigrate` workflow.
if [[ -n "${MIGRATION_FILES}" ]] ; then
  echo "generate an atlantis.yaml for tfmigrate"
  cat << EOF > atlantis.yaml
version: 3
projects:
- name: tfmigrate
  dir: tfmigrate
  autoplan:
    when_modified: ["*.hcl"]
    enabled: true
  workflow: tfmigrate
EOF
else
  echo "skip migration"
fi

echo "end pre_workflow_hooks"
