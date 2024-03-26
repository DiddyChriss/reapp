# Property App

## About Project
Simple API for managing properties, designed mostly for presentation/tutorials, as the typically
non-commercial app is more like proof of concept:
* inconsistency - as app themselves and also on AWS environment names may not be consistent and related to good practices
* tests covered need to be extended(including lambda)
* `UserManager` needs to be implemented
* linters needs to be implemented
* and so on..

### App contains:
* Core app
* User app
* Property app

## Tech Stack

* Python
* Django
* Django REST Framework
* Docker
* Docker-compose
* AWS

### AWS
* App contain two pipelines(CodePiepline)
  - Staging - Pipeline with stages Source, Build(codebuild), Tests(CodeBuild) and Deploy(CodeDeploy) to EC2 instance
  - PR - pipeline with stages Source, Build(codebuild), Tests(CodeBuild) integrated with GitHub PRs by SNS and Lambda function.

### Linux 

First you need to clone`git clone git@gitlab.com:zero-deposit/propertyapp.git`

Follow the instructions below:

1. include provided by author content to `.example.env`
2. run `make first_setup`
3. each subsequent run `make setup`

A specific Super User is created during the setup, with the following credentials provided in the `.env` file:

File `Makefile` contains all the commands needed to run the project.

### Troubleshooting
In case of any problems with the installation, please report to the author of the project.

