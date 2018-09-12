# AWS BASTION

https://docs.aws.amazon.com/quickstart/latest/linux-bastion/welcome.html

## Why a bastion

- Manage access to VMs from 1 single place
    - there is management access to the VMs (ssh) only from here + log this access
        - eg https://aws.amazon.com/blogs/security/how-to-record-ssh-sessions-established-through-a-bastion-host/
    - eg run provisioning (middleware, applications, ... from here) + log these runs (Cloudwatch PRODUCTIONREADY?)
    - it would need ssh configurations and credentials and maybe users

## Setup a bastion

- One is needed in each public subnet (might mean also in different availability zones)
- https://docs.aws.amazon.com/quickstart/latest/linux-bastion/step2.html (uses AWS CloudFormation instead of Terraform)

## A nice example setup to investigate that is using terraform

https://github.com/LeapBeyond/terraform-aws-bastion PRODUCTIONREADY

The example uses a bastion vpc and vpc peering. Not a bastion inside a public vpc with network acls. This seems a better infrastructure setup, but already somewhat complex in code then a keep-it-super-simple scenario.

