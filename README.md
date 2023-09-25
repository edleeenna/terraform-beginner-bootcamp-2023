# Terraform Beginner Bootcamp 2023

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


### Github Lifecycle (Before, Init, Command)

We need to be careful using the init because it will not rerun if we restart an existing workspace. 

https://www.gitpod.io/docs/configure/workspaces/tasks

