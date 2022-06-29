### Possible enhancements that can be made
Due to limited time and budget there are several elements of this repository that are sub-par and can be improved upon or enhanced.

I would look to enhance the following features:
- Make the website look better (pretty obvious, but the aim of this repository was around building the DevOps tools to support a static website and not really the UI)
- Use S3 for hosting the static website instead of lambda
    - S3 costs more but should have lower latency and no limits to number of users accessing the website at a given time.
- A CI/CD pipeline for running terraform 
    - removes need to manually run terraform (error prone)
    - can provides a nice GUI to run terraform and take variables as input
    - can handle secrets for terraform to access AWS
- Automated tests added to CI/CD pipeline
    - testing terraform may be difficult, but at the very least there can be a step to just run `terraform validate` which will uncover any basic errors in the terraform script, such as undefined variables 

