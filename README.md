This repository sets up and configures a very minimal static website hosted on AWS using lambda.

## Dependencies:
- `terraform`, see [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- An active AWS account with an IAM user that has an Access key ID and Access secret (to use with terraform)

## Folder structure:
- `lambda_code`: Contains all the code files needed to be deployed on the lambda function.
- `automation`: All terraform related files
- `.github/workflow`: contains CD pipeline

## CI/CD pipeline
The repository currently contains a GitHub Actions workflow for continuous deployment. The workflow runs on every merge to master and uploads a zipped file containing the files under `lambda_code` directory to AWS lambda to update the website to reflect the new changes merged to master. The new code uploaded replaces the existing code on lambda (i.e. there is no code versioning set-up on the lambda as of yet).

To run the pipeline directly:
1. Go to the `Actions` tab and select the `Update Website` workflow.
2. Click on a recent run
3. On the top right click "Re-run all jobs"
4. A new workflow job will be created and triggered

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
    - Allow creating release tags separately
    - Minimize merges into masters
    - Allow different CI/CD pipeline for the application code repository and the DevOps repository
    - Avoid accident changes to application code when automation scripts are worked on and vice-versa
2. Add master branch protection and require at least 1 approval for any merges into master 
    - Ensures master stays in a stable condition
3. Create different environments for dev, test and prod (maybe one for performance if needed)
    - Allows developers to work on features independent of testers
    - Allows different configurations for each environment (e.g. prod lambda can automatically be configured to have reserved concurrency)
4. Terraform updated to include tags to resources based on their environment and be able to easily select which environment to deploy the stack to (possibly made easy with a CI/CD pipeline like Jenkins or Travis because of it's GUI)
5. Buy a domain for the website and use perhaps `Route53` to route it to the lambda function url
6. Possibly need to add `S3` bucket to either host the website entirely or at least to store the website if it becomes too big to zip and upload to lambda through automation scripts
7. Add tests scripts to CI/CD pipeline (that runs on each pull request), should test both the application (website and nodejs code) and the automation script (can even use a simple `terraform validate` as one of the steps)
8. Terraform script extended to be able to destroy infrastructure
    - Helps destroy dev resources no longer needed
    - Helps to destroy and recreate infrastructure every now and then to ensure terraform script works correctly and uncover if any custom configuration was introduced to AWS to fix a particular issue but not added to automation script.
9. If using lambda, enable versioning so we do not accidentally update existing code and break changes with no version to revert back to through AWS.
10. Add pre-commit hook to git configuration to allow running and fixing formatting issues with nodejs and terraform script automatically with every commit
    - Ensures the code quality follows a standard format without developers explicitly formatting it
11. Disable merges into master to automatically deploy lambda code to production if required
    - In cases where testing through test and performance environment is not automated and needs to be manually done once dev code is pushed to master, production code deployment may need to be manually triggered once all testing is done