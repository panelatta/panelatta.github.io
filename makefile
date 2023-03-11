setup:
	brew install hugo
	git submodule add --depth 1 https://github.com/reuixiy/hugo-theme-meme.git themes/meme

update_theme_meme:
	git submodule update --rebase --remote

deploy_local:
	hugo server -D
	echo "open http://localhost:1313/"

new_post:
	hugo new "posts/$(name)"
