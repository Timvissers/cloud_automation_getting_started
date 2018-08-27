# TERRAFORM + AWS: https://www.terraform.io/intro/index.html

## https://www.terraform.io/intro/getting-started/install.html

- Download package
- Add to path

## https://www.terraform.io/intro/getting-started/build.html

- eu-central-1a (Frankfurt)
- Created a root access key. Instead I should use a iam user access key

In a real scenario, I would need to
- setup remote terraform state
- pin the aws provider plugin version

Now a empty EC2 vm is popped up. This would be all if we were using an image based infrastructure (eg with packer), but in any other case, you would provision.
Terraform supports provisioners as well.

## https://www.terraform.io/intro/getting-started/dependencies.html

## https://www.terraform.io/intro/getting-started/provision.html

- can be used to bootstrap a configuration management tool. However configuration management is now already considered an anti-pattern ;)

## https://www.terraform.io/intro/getting-started/variables.html
