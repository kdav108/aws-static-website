This repository sets up and configures a very minimal static website hosted on AWS using lambda.

## Dependencies:
- `terraform` must be installed
- An active AWS account with a user that has an Access key ID and Access secret (to use with terraform)

## Folder structure:
- `lambda_code`: Contains all the code files needed to be deployed on the lambda function.
- `automation`: All terraform related files

## Steps to create necessary stack
1. From `automation` initiate terraform using
```
terraform init
```

2. Add AWS access secrets
```
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
```
3. (Optional) Verify terraform is configured correctly
```
terraform validate
```
4. Run terraform
```
terraform apply
```
Review the output and if you confirm the changes marked are okay, type 'yes' to apply the changes
5. The website URL will be provided at as one of the outputs of the terraform apply command. Use it to access the static website!
