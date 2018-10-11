# KUBERNETES ON CLOUD - PROVIDER INDEPENDENT

https://kubernetes.io/docs/setup/pick-right-solution/

https://rancher.com/announcing-rke-lightweight-kubernetes-installer/


## Overview cloud independent

Looking for a cloud independent solution:

- RKE cloud independent, just k8s, not nodes creation. But they encourage managed kubernetes like gke, eks. It is lightweight and fast, and container based

- KOPS, installs nodes as well. Works best with aws. It does much more wiring up, but it's closely integrated with underlying cloud services
https://github.com/kubernetes/kops/blob/master/docs/aws.md
Plans for azure?
https://kubernetes.io/docs/setup/custom-cloud/kops/
http://connect.cd/2017/10/kops/

- KUBESPRAY cloud independent, as rke, but not container based

https://kubernetes.io/docs/setup/custom-cloud/kubespray/

- KUBEADM is not production grade

- GARDENER

https://kubernetes.io/blog/2018/05/17/gardener/

Looks harder to start with. Also it claims to handle all clouds, but is it there yet?

- KUBLR

Sets up clusters on any cloud, consuming eg AWS CloudFormation and Azure Resource Management Templates. So Kublr will create the notes

figure it out: https://kublr.com/industry-info/choosing-the-right-containerization-and-cluster-management-tool-2/


### RKE as installer (+ RANCHER)

what is it: https://stackoverflow.com/questions/39608002/how-is-rancher-different-from-kubernetes

Some links:

https://rancher.com/blog/2018/2018-05-14-rke-on-aws/ (just nodes, rke cluster roles to nodes + example deployment

https://github.com/infracloudio/rancher-tf-aws (custom terraform creating k8s in aws with rancher 1.4.1)

https://github.com/nextrevision/terraform-rancher-ha-example

https://github.com/rancher/terraform-modules (just rancher)

https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/rke-clusters/node-pools/ec2/ (creating a cluster with rancher 2.0)

https://github.com/rancher/ansible-playbooks

https://github.com/afgane/ansible-rancher


#### Possible setup

- install some nodes
- install kubernetes with rke
- (install rancher, eg with vagrant quickstart guide)


