all:
	git add -A \
	&& git commit -m "Update unix-bootstrap at $$(date)" \
	&& git push
