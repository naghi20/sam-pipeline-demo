#!/bin/bash

# This script generates the 'sam pipeline init' command with pre-answered questions.
# It assumes a GitHub source repository and AWS CodePipeline (using CodeBuild) for CI/CD.
# It also assumes a single 'dev' deployment stage.

# --- Configuration Variables ---
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Replace with your values
SAM_S3_BUCKET="sam-pipleline-skillu-demo"
AWS_REGION="eu-west-2"


# The base name for your SAM project and CloudFormation stacks.
PROJECT_BASE_NAME="my-sam-hello-world-pipeline-project"
SAM_TEMPLATE_FILE="template.yaml"

echo "Generating 'sam pipeline init' command..."
echo "Running the following command:"
echo ""

# The 'sam pipeline init' command with pre-answered options
# --pipeline-provider GITHUB: Specifies GitHub as the source code provider.
# --pipeline-type AWSCodePipeline: Specifies AWS CodePipeline as the CI/CD system.
# --scaffold-pipeline: Tells SAM CLI to generate the pipeline files.
# --project-name: The name for your SAM project in the pipeline context.
# --s3-bucket: The S3 bucket where SAM will package and deploy your application.
# --region: The AWS region for the pipeline and deployments.
# --stage-name dev: Defines the first (and in this case, only) deployment stage as 'dev'.
# --stack-name ${PROJECT_BASE_NAME}-dev: The CloudFormation stack name for the 'dev' stage.
# --template-file ${SAM_TEMPLATE_FILE}: Specifies the SAM template file.
# --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM: Grants necessary IAM permissions for deployments.
sam pipeline init \
  --pipeline-provider GITHUB \
  --pipeline-type AWSCodePipeline \
  --scaffold-pipeline \
  --project-name "${PROJECT_BASE_NAME}" \
  --s3-bucket "${SAM_S3_BUCKET}" \
  --region "${AWS_REGION}" \
  --stage-name dev \
  --stack-name "${PROJECT_BASE_NAME}-dev" \
  --template-file "${SAM_TEMPLATE_FILE}" \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

echo ""
echo "This command will generate pipeline configuration files in your project directory."
echo "You will typically find files like 'pipeline.yaml' for AWS pipeline type."
