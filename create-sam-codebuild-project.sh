#!/bin/sh

# This script creates an AWS CodeBuild project using the AWS CLI.
# Also, make sure to replace placeholder values with your actual GitHub repository URL
# and the ARN of your CodeBuild service role.

# --- Configuration Variables ---
PROJECT_NAME="my-sam-python-pipeline-build" # Name for your CodeBuild project

GITHUB_REPO_URL="https://github.com/mvpjava/sam-pipeline-demo.git"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Replace with your values
CODEBUILD_SERVICE_ROLE_ARN="arn:aws:iam::403177882230:role/service-role/mycodebuildservicerole"
AWS_REGION="eu-west-2" 


Replace with your CodeBuild service role ARN
BUILD_SPEC_FILE="buildspec.yml" # Path to your buildspec file within the repository (relative to root)

echo "Attempting to create AWS CodeBuild project: ${PROJECT_NAME}..."

aws codebuild create-project \
  --name "${PROJECT_NAME}" \
  --description "CodeBuild project for SAM Python pipeline" \
  --source type=GITHUB,location="${GITHUB_REPO_URL}",buildspec="${BUILD_SPEC_FILE}",gitCloneDepth=1 \
  --artifacts type=NO_ARTIFACTS \
  --environment type=LINUX_CONTAINER,image="aws/codebuild/standard:5.0",computeType=BUILD_GENERAL1_SMALL,privilegedMode=false \
  --service-role "${CODEBUILD_SERVICE_ROLE_ARN}" \
  --queued-timeout-in-minutes 5 \
  --timeout-in-minutes 5 \
  --region "${AWS_REGION}"

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
  echo "Successfully created CodeBuild project: ${PROJECT_NAME}"
else
  echo "Failed to create CodeBuild project: ${PROJECT_NAME}. Please check the error messages above."
  exit 1
fi

