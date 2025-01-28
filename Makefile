#!/usr/bin/make -f

# Color output
CYAN := \033[36m
RESET := \033[0m
BOLD := \033[1m

# Help function
define PRINT_HELP_PREAMBLE
Usage:
  make [target]

Targets:
endef
export PRINT_HELP_PREAMBLE

# Configuration
PYTHON := python3.13
VENV := venv
WORKSHOP_DIR := anthropic-citations-workshop
UV := $(VENV)/bin/uv
PIP := $(VENV)/bin/pip
JUPYTER := $(VENV)/bin/jupyter
PYTEST := $(VENV)/bin/pytest
BLACK := $(VENV)/bin/black
ISORT := $(VENV)/bin/isort

# Phony targets declaration
.PHONY: all setup venv deps clean test lint format help student-workspace update-deps dev-setup docs

# Default target
all: help

# Dynamic help target
help:
	@echo "$$PRINT_HELP_PREAMBLE"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(CYAN)%-20s$(RESET) %s\n", $$1, $$2}'

# Core targets with descriptions
setup: venv deps ## Initial setup of project environment
	mkdir -p $(WORKSHOP_DIR)/{data,notebooks,examples,tests}
	test -f .env.example || ./setup.sh
	@echo "$(CYAN)Setup complete. Next steps:$(RESET)"
	@echo "1. Copy .env.example to .env"
	@echo "2. Add your Anthropic API key to .env"

venv: ## Create Python virtual environment
	test -d $(VENV) || $(PYTHON) -m venv $(VENV)
	. $(VENV)/bin/activate && \
	curl -LsSf https://astral.sh/uv/install.sh | sh

deps: requirements.txt ## Install project dependencies
	. $(VENV)/bin/activate && \
	$(UV) pip install -r requirements.txt

requirements.txt: ## Generate requirements file
	@echo "$(CYAN)Generating requirements.txt...$(RESET)"
	@echo "anthropic>=0.8.0" > requirements.txt
	@echo "jupyter>=1.0.0" >> requirements.txt
	@echo "pandas>=2.0.0" >> requirements.txt
	@echo "rich>=13.0.0" >> requirements.txt
	@echo "jupytext>=1.14.5" >> requirements.txt
	@echo "pytest>=7.0.0" >> requirements.txt
	@echo "black>=23.0.0" >> requirements.txt
	@echo "isort>=5.12.0" >> requirements.txt
	@echo "nbconvert>=7.0.0" >> requirements.txt

clean: ## Clean up generated files
	@echo "$(CYAN)Cleaning up generated files...$(RESET)"
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name ".ipynb_checkpoints" -delete

test: deps ## Run tests
	@echo "$(CYAN)Running tests...$(RESET)"
	. $(VENV)/bin/activate && $(PYTEST) tests/

lint: deps ## Run linting checks
	@echo "$(CYAN)Running linting checks...$(RESET)"
	. $(VENV)/bin/activate && \
	$(BLACK) --check . && \
	$(ISORT) --check-only .

format: deps ## Format code with Black and isort
	@echo "$(CYAN)Formatting code...$(RESET)"
	. $(VENV)/bin/activate && \
	$(BLACK) . && \
	$(ISORT) .

notebook: deps ## Start Jupyter notebook
	@echo "$(CYAN)Starting Jupyter notebook...$(RESET)"
	. $(VENV)/bin/activate && $(JUPYTER) notebook

student-workspace: ## Create new student workspace
	@echo "$(CYAN)Creating student workspace...$(RESET)"
	@read -p "Enter student name: " name; \
	mkdir -p "student-notes/$$name"/{notebooks,exercises,solutions}; \
	cp -r examples "student-notes/$$name/"; \
	cp -r notebooks "student-notes/$$name/"; \
	git checkout -b "student/$$name"; \
	echo "Created workspace for $$name"

update-deps: requirements.txt ## Update dependencies to latest versions
	@echo "$(CYAN)Updating dependencies...$(RESET)"
	. $(VENV)/bin/activate && \
	$(UV) pip install -U -r requirements.txt

dev-setup: deps ## Install development tools
	@echo "$(CYAN)Setting up development environment...$(RESET)"
	. $(VENV)/bin/activate && \
	$(UV) pip install pytest black isort jupytext nbconvert

docs: ## Generate workshop documentation
	@echo "$(CYAN)Generating documentation...$(RESET)"
	. $(VENV)/bin/activate && \
	$(JUPYTER) nbconvert --to markdown notebooks/*.ipynb --output-dir docs/

# Workshop-specific targets
workshop-init: setup ## Initialize workshop environment and materials
	@echo "$(CYAN)Initializing workshop environment...$(RESET)"
	. $(VENV)/bin/activate && \
	$(JUPYTER) notebook notebooks/01_citations_api_intro.ipynb

validate-env: ## Validate environment setup
	@echo "$(CYAN)Validating environment...$(RESET)"
	@test -f .env || (echo "$(BOLD)Error: .env file missing$(RESET)" && exit 1)
	@test -d $(VENV) || (echo "$(BOLD)Error: virtualenv missing$(RESET)" && exit 1)
	@echo "Environment validation complete!"

# Utility targets
.SILENT: help clean notebook
