# Makefile for Python project with virtual environment

# Variables
VENV_NAME := venv
PYTHON := python3
PIP := $(VENV_NAME)/bin/pip
PYTHON_VENV := $(VENV_NAME)/bin/python
REQUIREMENTS := requirements.txt

# Default target
.PHONY: all
all: venv install

# Create virtual environment
.PHONY: venv
venv:
	@if [ ! -d "$(VENV_NAME)" ]; then \
		echo "Creating virtual environment..."; \
		$(PYTHON) -m venv $(VENV_NAME); \
		echo "Virtual environment created in ./$(VENV_NAME)"; \
	else \
		echo "Virtual environment already exists in ./$(VENV_NAME)"; \
	fi

# Install dependencies
.PHONY: install
install: venv
	@echo "Installing dependencies..."
	$(PIP) install --upgrade pip
	@if [ -f $(REQUIREMENTS) ]; then \
		$(PIP) install -r $(REQUIREMENTS); \
	else \
		echo "No requirements.txt found. Skipping dependency installation."; \
	fi
	@echo "Dependencies installed successfully!"

# Clean virtual environment
.PHONY: clean
clean:
	@echo "Removing virtual environment..."
	rm -rf $(VENV_NAME)
	@echo "Virtual environment removed."

# Reinstall everything
.PHONY: reinstall
reinstall: clean all

# Freeze current dependencies
.PHONY: freeze
freeze: venv
	@echo "Freezing dependencies to requirements.txt..."
	$(PIP) freeze > $(REQUIREMENTS)
	@echo "Dependencies frozen to $(REQUIREMENTS)"

# Run Python in virtual environment
.PHONY: run
run: venv
	$(PYTHON_VENV) main.py

# Show help
.PHONY: help
help:
	@echo "Python Virtual Environment Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make           - Create venv and install dependencies"
	@echo "  make venv      - Create virtual environment only"
	@echo "  make install   - Install dependencies from requirements.txt"
	@echo "  make clean     - Remove virtual environment"
	@echo "  make reinstall - Clean and reinstall everything"
	@echo "  make freeze    - Save current dependencies to requirements.txt"
	@echo "  make run       - Run main.py in virtual environment"
	@echo "  make help      - Show this help message"
	@echo ""
	@echo "To activate the virtual environment manually:"
	@echo "  source $(VENV_NAME)/bin/activate"