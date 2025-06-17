#!/bin/sh

aws cloudformation deploy \
 --template-file pipeline.yaml \
 --stack-name my-sam-pipeline-infrastructure \
 --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
 --region eu-west-2
