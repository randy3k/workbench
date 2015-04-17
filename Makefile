all:
	git add -A \
	&& git commit -m "Update bootstrap-server at $$(date)" \
	&& git push
