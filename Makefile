.PHONY: test verify

test:
	python3 -m unittest discover -s tests

verify:
	python3 verify_release.py
