# Makefile for Python project with virtual environment

# Variables
VENV_NAME := venv
PYTHON := python3
PIP := $(VENV_NAME)/bin/pip
PYTHON_VENV := $(VENV_NAME)/bin/python
REQUIREMENTS := requirements.txt
WHEEL_FILE := kesslergame-2.4.0-py3-none-any.whl

# Default target
.PHONY: all
all: venv install

# Create virtual environment
.PHONY: venv
venv:
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv $(VENV_NAME)
	@echo "Virtual environment created in ./$(VENV_NAME)"

# Install dependencies
.PHONY: install
install: venv
	@echo "Installing dependencies..."
	$(PIP) install --upgrade pip
	@if [ -f $(REQUIREMENTS) ]; then \
		$(PIP) install -r $(REQUIREMENTS); \
	else \
		echo "No requirements.txt found. Skipping requirements installation."; \
	fi
	@if [ -f $(WHEEL_FILE) ]; then \
		echo "Installing wheel file: $(WHEEL_FILE)"; \
		$(PIP) install $(WHEEL_FILE); \
	else \
		echo "No wheel file found at $(WHEEL_FILE). Skipping wheel installation."; \
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
freeze:
	@echo "Freezing dependencies to requirements.txt..."
	$(PIP) freeze > $(REQUIREMENTS)
	@echo "Dependencies frozen to $(REQUIREMENTS)"

# Install wheel file only
.PHONY: install-wheel
install-wheel: venv
	@if [ -f $(WHEEL_FILE) ]; then \
		echo "Installing wheel file: $(WHEEL_FILE)"; \
		$(PIP) install $(WHEEL_FILE); \
	else \
		echo "ERROR: Wheel file not found at $(WHEEL_FILE)"; \
		exit 1; \
	fi

# Run Python in virtual environment
.PHONY: run
run:
	$(PYTHON_VENV) main.py

# Activate virtual environment (info only)
.PHONY: help
help:
	@echo "Python Virtual Environment Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make             - Create venv and install dependencies"
	@echo "  make venv        - Create virtual environment only"
	@echo "  make install     - Install dependencies and wheel file"
	@echo "  make install-wheel - Install wheel file only"
	@echo "  make clean       - Remove virtual environment"
	@echo "  make reinstall   - Clean and reinstall everything"
	@echo "  make freeze      - Save current dependencies to requirements.txt"
	@echo "  make run         - Run main.py in virtual environment"
	@echo "  make help        - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  WHEEL_FILE = $(WHEEL_FILE)"
	@echo ""
	@echo "To activate the virtual environment manually:"
	@echo "  source $(VENV_NAME)/bin/activate"