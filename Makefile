## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ./.venv
	. ./.venv/bin/activate

install:
	# This should be run from inside a virtualenv
    sudo pip3 install --upgrade pip &&\
		pip3 install -r requirements.txt --user
	

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	#docker run --rm -i hadolint/hadolint < Dockerfile
	hadolint Dockerfile
	# sudo /usr/local/bin/hadolint Dockerfile --ignore=DL3013
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 app.py

all: install lint test
