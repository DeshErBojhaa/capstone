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
	. .venv/bin/activate

install:
	pip3 install -r requirements.txt
	
lint:
	hadolint Dockerfile
	#pylint --disable=R,C,W1203 app.py

all: install lint
