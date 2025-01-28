#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [student-name]"
    exit 1
fi

STUDENT_NAME=$1
WORKSPACE_DIR="student-notes/${STUDENT_NAME}"

# Create directory structure
mkdir -p "${WORKSPACE_DIR}"/{notebooks,exercises,solutions}

# Create student config
cat > "${WORKSPACE_DIR}/config.yml" << EOF
student:
  name: ${STUDENT_NAME}
  created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
workshop:
  name: Anthropic Citations API
  year: 2025
EOF

# Create git branch
git checkout -b "student/${STUDENT_NAME}"

# Initialize notebooks with jupytext
cat > "${WORKSPACE_DIR}/notebooks/01_introduction.md" << EOF
---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.14.5
---

# Introduction to Citations API

## Setup Verification

\`\`\`python
import anthropic
import os
from rich import print

# Verify environment
print("Environment Check:")
print(f"Python Version: {sys.version}")
print(f"Anthropic SDK Version: {anthropic.__version__}")
\`\`\`
EOF

echo "Student workspace created at ${WORKSPACE_DIR}"
echo "Git branch student/${STUDENT_NAME} created"
