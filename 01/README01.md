# TERRAFORM + AWS:
https://www.terraform.io/intro/index.html

## https://www.terraform.io/intro/getting-started/install.html

- Download package
- Add to path
- Installation: PRODUCTIONREADY should be automated as well

## https://www.terraform.io/intro/getting-started/build.html

- eu-central-1a (Frankfurt)
- Created a root access key. PRODUCTIONREADY: should use a iam user access key

In a real scenario, I would need to
- PRODUCTIONREADY: setup remote terraform state backend
- PRODUCTIONREADY: pin the aws provider plugin version

Now a empty EC2 vm is popped up. This would be all if we were using an image based infrastructure (eg with packer), but in any other case, you would provision.
Terraform supports provisioners as well.

## https://www.terraform.io/intro/getting-started/dependencies.html

## https://www.terraform.io/intro/getting-started/provision.html

- can be used to bootstrap a configuration management tool. However configuration management is now already considered an anti-pattern ;)

## https://www.terraform.io/intro/getting-started/variables.html

## accessing

### create a keypair (done manually)
- You cannot associate your keypair with an already running instance
- created the keypair in aws manually, named cloud_automation_getting_started. If done through the browser, the private key is automatically downloaded: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html. The public key can be generated from the private key: ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
-
        chmod 400 ~/.ssh/cloud_automation_getting_started.pem

### link the keypair to the instance (done via terraform)
- via the aws_key_pair resource and adding the keyname to the aws_instance

### add a security group inbound rule (done via terraform)
- by default, you cannot connect to the instance due to security groups: the default security group is in use and it does not allow your inbound connection. It allows only access from other machines inside the default security group. For now, add your remote ip to the default security group. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html
- via the aws_vpc and aws_default_security_group resources
- how about egress: there should be no outgoing traffic for our current security group setup

### connect
- connect to the outputted ip, or ec2-<outputtedIPseparatedbydashes>.eu-central-1.compute.amazonaws.com
- ~./ssh/config (PRODUCTIONREADY: should be generated, based on outputted IP). Note that ubuntu user is the default user for our ami: https://alestic.com/2014/01/ec2-ssh-username/

        Host cloud_automation_getting_started
        Hostname ec2-18-184-51-158.eu-central-1.compute.amazonaws.com
        User ubuntu
        IdentityFile ~/.ssh/cloud_automation_getting_started.pem
-
        ssh -v cloud_automation_getting_started

### gather info from the system
Note that this specific one is an ubuntu.
- memory: free -h (1gb for this t2.micro)
- cpu: nproc (1)
- ip a: 172.31.31.157/20
- ip r: default via 172.31.16.1 dev eth0
        172.31.16.0/20 dev eth0  proto kernel  scope link  src 172.31.31.157
- uname: Linux ip-172-31-31-157 4.4.0-1065-aws #75-Ubuntu SMP Fri Aug 10 11:14:32 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
