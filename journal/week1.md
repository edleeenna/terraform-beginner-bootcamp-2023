# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

Locally delete a tag:

```sh
git tag -d <tag_name>
```
Remotely delete a tag:
```sh
git push --delete origin tagname
```

Checkout the git commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

[How to delete local and remote tags on git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

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

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually. 

You can use terraform import but it wont work for all cloud resources. You need to cheack the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and deletes or modifies cloud resources manully through ClickOps.

If we run Terraform plan again, it will attempt to put our infrastructure back into the expected state fixing Configuration Drift


## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.

The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
} 
```

### Modules Sources

Using the source we can import the module from various place e.g:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
} 
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older example that could be deprecated. Often affecting providers.

## Working with Files in Terraform

### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
   condition  = fileexists(var.error_html_filepath)
```

[fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths.
- path.module
- path.root
- path.cwd


[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

### Terraform Locals

[Locals](https://developer.hashicorp.com/terraform/language/values/locals)

Locals allow us to define local variables.
It can be very useful when we need to transform data into another format and have referenced as a variable

```tf
locals {
  s3_origin_id = "myS3Origin"
}
```

### Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)


## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)