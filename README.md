This repository sets up and configures a very minimal static website hosted on AWS using lambda.

## Dependencies:
- `terraform` must be installed, see [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- An active AWS account with an IAM user that has an Access key ID and Access secret (to use with terraform)

## Folder structure:
- `lambda_code`: Contains all the code files needed to be deployed on the lambda function.
- `automation`: All terraform related files
- `.github/workflow`: contains CD pipeline

## Steps to replicate the website
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
Review the output and if you confirm the changes marked are okay, type 'yes' to apply the changes.

5. The website URL will be provided at as one of the outputs of the terraform apply command. Use it to access the static website!

### Solution design overview and alternatives
The overall solution design is quite simple and can be read up on [here](solution_design.md), including the alternatives that were considered

### Possible improvements/enhancements
[See the possible enhancements that can be made to this repository](possible_enhancements.md)


### Other improvement to make this production ready
1. To allow multiple developers working on this project, the DevOps tools/scripts should be separated into it's own repository and the website code added to it's own repository
2. Add master branch protection and require at least 1 approval for any merges into master (to ensure master stays in a stable condition)
3. Create different environments for dev, test and prod (maybe one for performance if needed)
4. Terraform updated to include tags to resources based on their environment and be able to easily select which environment to deploy the stack to (possibly made easy with a CI/CD pipeline like Jenkins or Travis)
5. But a domain for the website and use perhaps Route53 to route it to the lambda function url
6. Possibly need to add S3 bucket to either host the website entirely or at least to store the website if it becomes too big to zip and upload to lambda through automation
7. Add tests scripts to CI/CD pipeline (that runs on each pull request), should test both the application (website and nodejs code) and the automation script (can even use a simple `terraform validate` as one of the steps)
8. Terraform script extended to be able to destroy infrastructure
9. If using lambda, enable versioning so we do not accidentally update existing code and break changes with no version to revert back to through AWS.