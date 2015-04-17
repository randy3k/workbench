all:
	git add -A \
	&& git commit -m "Update server-bootstrap at $$(date)" \
	&& git push
