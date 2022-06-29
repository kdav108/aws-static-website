### Solution Design
This static website has a very basic stack, it consists of
- a nodejs backend
- raw html for frontend
- lambda for hosting the website
- github Actions for CD pipeline

There was no use of a Domain Registrar to provide the website with a more human friendly domain name. This could have been provided easily within AWS using Route 53, but was avoided to not incur any costs for this project.

### Alternatives considered
requirement | possible solutions | solution chosen | reason | disadvantages of solution chosen
----- | ------ | ----- | ----- | ---- |
Hosting website | S3 or Lambda (GCP solutions not considered due to lack of familiarity) | Lambda | Lambda was a free service - no budget for this project :) | Lambda will not support more than 1000 concurrent invocations, hence any user over 1000 users accessing the website at the same time will experience greater latency (although rare situation). \n Accessing website the first time may incur greater latency than average (although can be fixed)
Stack deployment | CloudFormation, Terraform | Terraform | Terraform is cloud agnostic (interacting with other cloud providers in the same terraform script will be easier if such a case arises in the future) | CloudFormation can be edited from AWS console, and is much more deeply integrated with AWS services |
CI/CD | Jenkins, Travis, Github Actions | Github Actions | Fastest to setup, integrates well with github triggers such as PR and merges | Not a great UI, not convenient to trigger manually |
Lambda code language | python, nodejs | nodejs | If the website is built to be more complicated in the future, it will most likely use JavaScript, hence it makes it easy and consistent to use the same language for the backend lambda handler function | None for the scope of this project |




