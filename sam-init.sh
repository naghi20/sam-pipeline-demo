#!/bin/sh

echo "Starting $0"
sam init --runtime python3.9 --name sam-python-app --app-template  hello-world

aws s3 mb s3://sam-pipleline-skillu-demo

echo "Exited $0"
