#!/bin/bash
set -euo pipefail

echo "Staging and committing workshop updates..."

# Fix Python module name if needed
if [ -f "modules/citations_helper/**init**.py" ]; then
    mv "modules/citations_helper/**init**.py" "modules/citations_helper/__init__.py"
fi

# Stage all changes
git add README.org
git add citation-system.mmd
git add git-commit.sh

# Create commit with structured message
git commit -m "feat(docs): enhance workshop documentation

- Updated README.org with:
  - Interactive babel sessions
  - Mermaid system diagrams
  - Advanced RAG patterns
  - Senior engineer focus

- Added system architecture diagrams:
  - Citation processing flow
  - RAG system components
  - Integration patterns

Technical Details:
- Added org-babel interactive examples
- Integrated Mermaid diagrams
- Enhanced documentation structure
- Updated testing strategies

Closes #issue_number"

# Push changes to remote
git push origin main

echo "Changes committed and pushed!"
echo "Next: Verify changes on remote repository"
