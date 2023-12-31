# Terraform Beginner Bootcamp 2023

## Table of Contents

- [Semantic Versioning :mage:](#semantic-versioning-mage)
- [Install the Terraform CLI](#install-the-terraform-cli)
   * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
   * [Considerations for Linux distribution](#considerations-for-linux-distribution)
   * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
   * [Shebang Considerations](#shebang-considerations)
      + [Execution Considerations](#execution-considerations)
      + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle (Before, Init, Command)](#gitpod-lifecycle-before-init-command)
- [Working with Env Vars](#working-with-env-vars)
   * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
   * [Printing Vars](#printing-vars)
   * [Scoping of Env Vars](#scoping-of-env-vars)
   * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
   * [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
   * [Terraform Registry](#terraform-registry)
   * [Terraform Console](#terraform-console)
      + [Terraform Init](#terraform-init)
      + [Terraform Plan](#terraform-plan)
      + [Terraform Apply](#terraform-apply)
      + [Terraform Destroy](#terraform-destroy)
   * [Terraform Lock Files](#terraform-lock-files)
   * [Terraform State Files](#terraform-state-files)
   * [Terraform Directory ](#terraform-directory)
- [Issues with Terraform Cloud login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)
Given a version number MAJOR.MINOR.PATCH, increment the:

The general format:

**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI Installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scriptong for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux distribution

This project is built against Ubuntu. Please consider checking your linux distribution and change accordingly to your distribution needs.

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking os version:

```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues we noticed the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [.bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod task file ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us to have an easier time to debug and execute manually Terraform CLI
- This will allow better portability for other projects that need to install Terraform CLI

### Shebang Considerations
A Shebang (pronounced Sha-bang) tells the bash script what program  will interpret the script: e.g. `#!/bin/bash`

ChatGPT recommends this format for bash: `#!/usr/bin/env bash`

- for portability
- for different os distributions
- will search the user's PATH for the bash executable

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations
When executing the bash script we can use the `./` shorthand notation to execut the bash script.

e.g. `./bin/install_terraform_cli`

if we are using a script in gitpod.yml we need to point the script to a program to interpret it:

e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

Linux permissions works as follows

In order to make our bash scripts executable we need to change linux permissions for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 700x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod


## Gitpod Lifecycle (Before, Init, Command)

We need to be careful using the init because it will not rerun if we restart an existing workspace. 

https://www.gitpod.io/docs/configure/workspaces/tasks


## Working with Env Vars

We can list out all environment variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set an env var without writing export e.g.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an Env var using echo e.g. `echo $HELLO`

### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future terminals that are open, you need to set env vars in your bash profile.

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world

```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check if our AWS credentials is configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this

```json
{
    "UserId": "AISAYGNWSFYC0FSNE0RJM",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/"
}
```

We'll need to generate AWS CLI credits from IAM User in order to use the AWS CLI

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io) 

- **Providers** is an interface to APIs that will allow you to create resources in terraform.
- **Modules** are a way to make large amounts of terraform code modular, portable and sharable.

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will destroy resources. 

You can also use the auto approve flag to skip the approve prompt
eg. `terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File should be committed to your version control system e.g. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. 

This file **should not be committed** to your version control system.

This file can contain sensitive data

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory 

`.terrform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud login and Gitpod Workspace

When attempting to run `terraform login` it will launch a wiswig view to generate a token. However it does not work epexteced in Gitpod VsCode in the browser.

The workaround is to manually generate a token in TerraForm Cloud

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
    "credentials": {
        "app.terraform.io": {
            "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
        }
    }
}
```
We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)
