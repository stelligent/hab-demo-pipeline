#!/bin/bash -x
set -o pipefail

error(){ echo ${1}; exit 1; }

# env variables
[ -z ${AWS_PROFILE} ] && error "Please be sure AWS_PROFILE is set in the environment"
[ -z ${LAMBDA_BUCKET} ] && error "Please be sure LAMBDA_BUCKET is set in the environment"

LAMBDA_ARCHIVE="dist/pipeline-runner.zip"

aws s3api create-bucket --bucket ${LAMBDA_BUCKET} --profile ${AWS_PROFILE}

if [ ! -e lambda/${LAMBDA_ARCHIVE} ] || [ "$1" = "lambda" ]; then
  pushd .
  cd lambda
  npm install
  rm ${LAMBDA_ARCHIVE}
  zip -r ${LAMBDA_ARCHIVE} * -i "./package.json" "./index.js" "./lib/*" "./node_modules/*"
  aws s3 cp ${LAMBDA_ARCHIVE} s3://${LAMBDA_BUCKET}/ --profile ${AWS_PROFILE}
  popd
fi

if [ "$1" != "lambda" ]; then
  node bootstrap.js "$1"
fi
