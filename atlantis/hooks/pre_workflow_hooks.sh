#!/bin/bash

set -euo pipefail

# https://www.runatlantis.io/docs/pre-workflow-hooks.html
echo "start pre_workflow_hooks"

# Check if there are any unapplied migrations left.
# This example assumes history mode.
# https://github.com/minamijoyo/tfmigrate#history-block
# If you are not using history mode, you need to detect a new migration file
# from pull request metadata by yourself.
MIGRATION_FILES=$(tfmigrate list --status=unapplied)
echo "MIGRATION_FILES: $MIGRATION_FILES"

# If exists, generate a project with `tfmigrate` workflow.
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
