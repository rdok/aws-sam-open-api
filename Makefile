DEPLOY_BUCKET := aws-sam-cli-managed-default-samclisourcebucket-gls3cd4hrabc
export DEPLOY_BUCKET

start-api:
	sam build
	sam local start-api --port 3010

build-deploy:
	aws --profile rdok s3 cp open-api/ s3://$${DEPLOY_BUCKET}/open-api/ --recursive
	sam build
	sam deploy --profile rdok --parameter-overrides \
		OpenAPIReference="s3://$${DEPLOY_BUCKET}/open-api"