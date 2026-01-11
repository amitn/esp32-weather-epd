.PHONY: deps install-deps icons build upload monitor upload-monitor clean clean-icons help

# PlatformIO directory
PLATFORMIO_DIR = platformio

# Icons directory
ICONS_DIR = icons

# PlatformIO command - use uv run if available, otherwise assume platformio is in PATH
PIO = uv run platformio

# Python command - use uv run to access venv dependencies
PYTHON = uv run python3

help:
	@echo "Available targets:"
	@echo "  deps           - Install Python dependencies using uv"
	@echo "  install-deps   - Alias for deps"
	@echo "  icons          - Generate icon header files from SVG files"
	@echo "  build          - Build the PlatformIO project"
	@echo "  upload         - Upload firmware to ESP32"
	@echo "  monitor        - View serial output from ESP32"
	@echo "  upload-monitor - Upload firmware and then open serial monitor"
	@echo "  clean          - Clean build artifacts"
	@echo "  clean-icons    - Clean generated icon files"
	@echo ""
	@echo "After running 'make deps', you can use 'make build' etc. directly,"
	@echo "or activate the virtual environment for direct platformio access:"
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

icons:
	@echo "Generating icon header files from SVG files..."
	@echo "Note: This requires Inkscape to be installed"
	@if ! command -v inkscape >/dev/null 2>&1; then \
		echo "Warning: Inkscape not found. Icon generation may fail."; \
		echo "Install Inkscape: https://inkscape.org/release/"; \
	fi
	@cd $(ICONS_DIR) && $(MAKE) all PYTHON="$(PYTHON)"

clean-icons:
	@echo "Cleaning generated icon files..."
	@cd $(ICONS_DIR) && $(MAKE) clean

build:
	@echo "Building PlatformIO project..."
	$(PIO) run -d $(PLATFORMIO_DIR)

upload:
	@echo "Uploading firmware to ESP32..."
	$(PIO) run -d $(PLATFORMIO_DIR) --target upload

monitor:
	@echo "Opening serial monitor..."
	$(PIO) device monitor -d $(PLATFORMIO_DIR)

upload-monitor: upload
	@echo "Opening serial monitor..."
	$(PIO) device monitor -d $(PLATFORMIO_DIR)

clean:
	@echo "Cleaning build artifacts..."
	$(PIO) run -d $(PLATFORMIO_DIR) --target clean
