set -x
export STACK_NAME=amplify-demo
export AWS_DEFAULT_REGION=ap-south-1

[ -z "$STACK_NAME" ] && echo "Please specify STACK_NAME environment variable" && exit 1;
[ -z "$AWS_DEFAULT_REGION" ] && echo "Please specify AWS_DEFAULT_REGION environment variable" && exit 1;

sam deploy --guided --stack-name $STACK_NAME

export AWS_COGNITO_REGION=$AWS_DEFAULT_REGION
export AWS_USER_POOLS_WEB_CLIENT_ID=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='CognitoClientID'].OutputValue" --output text`
export API_BASE_URL=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='TodoFunctionApi'].OutputValue" --output text`
export STAGE_NAME_PARAM=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Parameters[?ParameterKey=='StageNameParam'].ParameterValue" --output text`
export COGNITO_HOSTED_DOMAIN=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='CognitoDomainName'].OutputValue" --output text`
export REDIRECT_URL=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='AmplifyURL'].OutputValue" --output text`

cp www/src/config.default.js www/src/config.js
