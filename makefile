.PHONY: setup update_theme deploy_local new_post

HUGO_THEME_URL = https://github.com/nunocoracao/blowfish.git
THEME_DIR = themes/blowfish

LOCALHOST_URL = http://localhost:1313/

POST_DIR = posts

setup:
	@which brew > /dev/null || { echo "Homebrew not installed. Please install it first."; exit 1; }
	@which hugo > /dev/null && { echo "Updating Hugo..."; brew upgrade hugo; } || { echo "Hugo not found. Installing..."; brew install hugo; }
	@git submodule add -b main "$(HUGO_THEME_URL)" "$(THEME_DIR)" || echo "Submodule already exists."

update_theme:
	@git submodule update --rebase --remote

deploy_local:
	@hugo server -D
	@sleep 2
	@open $(LOCALHOST_URL)

new_post:
	@if [ -z "$(name)" ]; then \
		echo "Error: post name is not set. Use 'make new_post name=\"your-post-title\"'"; \
		exit 1; \
	fi
	@hugo new "$(POST_DIR)/$(name).md"