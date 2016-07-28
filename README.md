## hab-demo-pipeline

This is a POC for automating Habitat with AWS CodePipeline

**Prereqs**
```
nodejs
npm
aws-cli
```

**Setup**
```
git clone https://github.com/stelligent/hab-demo-pipeline
cd hab-demo-pipeline
npm install
```

**Config**
```
1. export AWS_PROFILE=your-profile-name
   export LAMBDA_BUCKET=a-unique-bucket-name

2. Update the values in awsConfig.json or copy it to a new file called awsConfig.local.json.
awsConfig.local.json will be used if it exists.
```

**Usage**

```
# Build and deploy the Lambda package and stage it on S3
./bootstrap lambda

# Deploy a CFN stack to create the Lambda function and CodePipeline
./bootstrap.sh deploy

# Delete the CFN stack
./bootstrap.sh destroy
```
