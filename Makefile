.PHONY: deps install-deps help

help:
	@echo "Available targets:"
	@echo "  deps          - Install Python dependencies using uv"
	@echo "  install-deps  - Alias for deps"
	@echo ""
	@echo "After running 'make deps', activate the virtual environment:"
	@echo "  source .venv/bin/activate  # Linux/Mac"
	@echo "  .venv\\Scripts\\activate     # Windows"

deps: install-deps

install-deps:
	@echo "Installing dependencies with uv..."
	uv sync
	@echo ""
	@echo "Dependencies installed! To activate the virtual environment, run:"
	@echo "  source .venv/bin/activate  # Linux/Mac"
	@echo "  .venv\\Scripts\\activate     # Windows"
