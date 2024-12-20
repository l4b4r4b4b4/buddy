SHELL := /bin/sh

# Fallback to bash if sh is not available
ifeq (, $(shell which sh))
	SHELL := /bin/bash
endif

# Default target
.PHONY: all
all: train


USE_SUDO := $(shell which docker >/dev/null && docker ps 2>&1 | grep -q "permission denied" && echo sudo)
DOCKER := $(if $(USE_SUDO), sudo docker, docker)
# DIRNAME := $(notdir $(CURDIR))
HAS_NVIDIA_GPU := $(shell which nvidia-smi >/dev/null 2>&1 && nvidia-smi --query --display=COMPUTE >/dev/null 2>&1 && echo ok)
OS := $(shell uname -s)

# Manually set to False for testing purposes
# HAS_NVIDIA_GPU := False
ifeq ($(OS),Darwin)
 # macOS detected, use 'docker compose' instead of 'docker-compose'
 COMPOSE := docker compose
else
 COMPOSE := docker-compose
endif

ifeq ($(OS),Darwin)
	# macOS detected
	COMPOSE_FILE := docker-compose.mac.yml
else ifeq ($(HAS_NVIDIA_GPU),ok)
	# @echo "NVIDIA GPU detected. Using with vLLM for text generation inference."
	COMPOSE_FILE := docker-compose.yml
else
	# @echo "NO NVIDIA GPU detected. Using CPU with llama-cpp-python for text generation inference."
	COMPOSE_FILE := docker-compose.yml
	# COMPOSE_FILE := docker-compose.cpu.yml
endif

# Development commands
dev-copy-env:
	@if [ -f ".env" ]; then \
		read -p ".env file already exists. Do you want to overwrite it? (y/n): " choice; \
		if [ "$$choice" = "y" ]; then \
			cp example.env .env; \
			echo "Overwritten .env from example.env"; \
		else \
			echo "Keeping existing .env file"; \
		fi \
	else \
		cp example.env .env; \
		echo "Created .env from example.env"; \
	fi; \
	cp -f .env apps/webapp/.env; \
	echo "Copied .env to apps/webapp/.env";

# Train target
.PHONY: training
training:
	@echo "Running train.sh..."
	@chmod +x ./train.sh
	@./train.sh
