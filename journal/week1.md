# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf          # everything else
├── variables.tf     # stores the structure of input variables
├── providers.tf     # defines required providers and their configuration
├── outputs.tf       # stores our outputs
├── terraform.tfvars # the data of variables we want to load into our terraform project
└── README.md        # required for root modules
```

[Standard Root Module](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input variables
## Terraform Cloud variables

In terraform we can set two kinds of variables:
- Environment variables - those you would set in your bash terminal eg. AWS Credentials
- Terraform variables - those that you would normall set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my_user_id"`

### var-file flag

The `-var-file` flag is used to pass Input Variables into the Terraform `plan` and `apply` commands using a file that contains the values.

Here is an example .tfvars file defining a few input variables

```
environment = 'production'
location    = 'eastus'

vm_instance_count = 4
vm_ip_allow_list  = [
  '10.50.0.1/32'
  '10.83.0.5/32'
]
```

[Terraform var file flag](https://build5nines.com/use-terraform-input-variables-to-parameterize-infrastructure-deployments/)

### terraform.tfvars

This is the default file to load in a terraform variables in bulk

### auto.tfvars

You can provide input variables using auto.tfvars files. You can create a file with an extension with `auto.tfvars`. It can be called whatever you like. With this extension, variables inside the files are automatically loaded during `terraform plan` or `terraform apply`

[auto.tfvars](https://terraformguru.com/terraform-certification-using-azure-cloud/24-Input-Variables-Assign-with-auto-tfvars/)

### Order of Terraform Variables

Terraform uses a specific order of precedence when determining the value of a variable. If the same variable is assigned multiple values, Terraform will use the value of highest precedence, overriding any other values. Below is the precedence order starting from the highest priority to the lowest.

1. Environment variables (TF_VAR_variable_name)
2. The terraform.tfvars file
3. The terraform.tfvars.json file
4. Any .auto.tfvars or .auto.tfvars.json files, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided.
6. Variable defaults

[Order of Terraform Variables](https://www.env0.com/blog/terraform-variables)


