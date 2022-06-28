### Possible enhancements that can be made
Due to limited time there are several elements of this repository that can be improved upon or enhanced.

I would look to enhance the following features:
- Make the website look better (pretty obvious, but the aim of this repository was around building the DevOps tools to support a static website)
- Use S3 for hosting the static website instead of lambda
    - S3 costs more but should have lower latency and no limits to number of users accessing the website at a given time.
- A CI/CD pipeline for running terraform 
    - removes need to manually run terraform (error prone)
    - can provides a nice GUI to run terraform and take variables as input
    - can handle secrets for terraform to access AWS

