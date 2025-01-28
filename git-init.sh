
# First, create a comprehensive .gitignore
cat > .gitignore << 'EOL'
# Emacs specific
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc
auto-save-list
tramp
.\#*
.org-id-locations
*_archive
*_flymake.*
/eshell/history
/eshell/lastdir
*.rel
/auto/
.cask/

# Org-mode
.org-id-locations
*_archive
ltximg/**
*.tex
*.pdf
*.html
*.org~

# Babel output files
/babel.*.el
/babel.*.org
/babel.*.sh
/babel.*.py
/babel.*.json

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
.pytest_cache/
.coverage
htmlcov/

# Virtual Environment
venv/
ENV/
env/
.env
.venv

# IDE
.idea/
.vscode/
*.swp
*.swo

# macOS
.DS_Store
.AppleDouble
.LSOverride
._*

# Workshop specific
student-notes/*/personal/
*.log
/data/*.csv
/data/*.json
results/

# Backup files
backup/
*.bak
*.backup
*.old
EOL

# Initialize git
git init

# Create .git/hooks/pre-commit for Emacs cleanup
cat > .git/hooks/pre-commit << 'EOL'
#!/bin/bash

# Clean up Emacs backup files before commit
find . -type f -name "*~" -delete
find . -type f -name "#*#" -delete

# Check for unresolved merge conflicts
if grep -rI '^<<<<<<< ' .; then
    echo "ERROR: Unresolved merge conflicts found"
    exit 1
fi
EOL
chmod +x .git/hooks/pre-commit

# Add files
git add README.org
git add Makefile
git add scripts/create-student-workspace.sh
git add DEVELOPMENT.md
git add .gitignore

# Initial commit with proper message
git commit -m "Initial commit

- Added project structure
- Set up Emacs/org-mode configuration
- Created Makefile for build automation
- Added student workspace scripts
- Configured .gitignore for Emacs/org-mode development

Project structure:
- README.org: Main documentation
- Makefile: Build automation
- scripts/: Workshop automation scripts
- DEVELOPMENT.md: Development guidelines"

# Show status
git status

# Create development branch
git checkout -b develop

echo "Git repository initialized with Emacs/org-mode configuration"
echo "Current branch: develop"
echo "Next steps:"
echo "1. Add remote: git remote add origin <repository-url>"
echo "2. Push changes: git push -u origin develop"
EOL
