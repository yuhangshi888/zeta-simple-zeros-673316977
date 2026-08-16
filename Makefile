.PHONY: test verify lean

test:
	python3 -m unittest discover -s tests

verify:
	python3 verify_release.py

lean:
	cd lean && lake build && lake env lean Audit.lean
