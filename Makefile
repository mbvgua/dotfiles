# these are commands not real files
.PHONY: help install-stow symlink-dotfiles install

# default command to run if no targets provided
.DEFAULT: help

help: ## Show this help message
	@command -v awk >/dev/null 2>&1 || { \
		printf >&2 '%s\n' "awk not found. Install gawk: https://www.gnu.org/software/gawk/"; \
		exit 1; \
	}
	@awk 'BEGIN { \
			FS = ":.*##"; \
			printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"; \
		} \
		/^##@/ { \
			line = $$0; \
			sub(/^##@[ \t]*/, "", line); \
			printf "\n\033[1m%s\033[0m\n", line; \
			next; \
		} \
		/^[a-zA-Z0-9_%\/.$$()-]+:.*##/ { \
			found = 1; \
			desc = $$2; \
			gsub(/^[ \t]+|[ \t]+$$/, "", desc); \
			printf "  \033[36m%-24s\033[0m %s\n", $$1, desc; \
		} \
		END { if (!found) printf "  (no documented targets)\n"; }' \
		$(MAKEFILE_LIST)

install-stow: ## Install GNU Stow if not already installed
	@echo "checking for stow..."
	@if command -v stow &>/dev/null; then \
		echo "stow is already installed"; \
	else \
		echo "installing stow..."; \
		sudo dnf isntall stow || { echo "failed to install stow"; exit 1; }; \
		echo "stow installed successfully"; \
	fi

symlink: ## Symlink dotfiles using stow
	@echo "symlink dotfiles..."
	@stow --adopt -t ~ . || { echo "failed to symlink dotfiles with stow"; exit 1; }
	@echo "dotfiles symlinked successfully"

install: ## Run script to install and setup programs
	@echo "installing programs..."
	@./install

