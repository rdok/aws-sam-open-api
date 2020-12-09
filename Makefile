DEPLOY_BUCKET := aws-sam-cli-managed-default-samclisourcebucket-gls3cd4hrabc
STACK_NAME := rdok-openapi-showcase
REFERENCE_DIR := aws-sam-open-api-reference
export

start-api:
	sam build
	sam local start-api --port 3010

build-deploy:
	aws --profile rdok s3 cp $${REFERENCE_DIR}/ \
		s3://$${DEPLOY_BUCKET}/$${REFERENCE_DIR}/ --recursive
	sam build
	sam deploy --profile rdok --parameter-overrides \
		OpenAPIReference="s3://$${DEPLOY_BUCKET}/$${REFERENCE_DIR}"

export-openapi:
	API_ID=$$(aws cloudformation describe-stacks  \
		  --stack-name "${STACK_NAME}" \
		  --query 'Stacks[0].Outputs[?OutputKey==`ApiID`].OutputValue' \
		  --output text); \
	aws --profile rdok --region eu-west-1 apigateway get-export \
		--rest-api-id "$${API_ID}" \
		--stage-name Prod \
		--export-type oas30 \
		$${REFERENCE_DIR}/export/exported-prod-open-api.yaml
