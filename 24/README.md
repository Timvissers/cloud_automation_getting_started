# KUBERNETES ON CLOUD - HOSTED SOLUTIONS: EKS

EKS is now kubernetes conformant certified: https://www.cncf.io/certification/software-conformance/

https://aws.amazon.com/blogs/aws/amazon-eks-now-generally-available/

based on https://aws.amazon.com/getting-started/projects/deploy-kubernetes-app-amazon-eks/

We could have used multiple ansible tasks, here is one for the cluster itself: https://docs.ansible.com/ansible/devel/modules/aws_eks_cluster_module.html

## Preparation

- iam role
- vpc (in Ireland)
- set up kubectl on client
- set up aws iam authenticator on client
- set up aws cli on client

## Step 1: Create Your Amazon EKS Cluster

## Step 2: Configure kubectl for Amazon EKS

aws eks update-kubeconfig --name my-eks-cluster --region eu-west-1

## Step 3: Launch and Configure Amazon EKS Worker Nodes

kubectl get nodes --watch

## Step 4: Step 4: Launch a Guest Book Application

kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/redis-master-controller.json
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/redis-master-service.json
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/redis-slave-controller.json
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/redis-slave-service.json
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/guestbook-controller.json
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/v1.10.3/examples/guestbook-go/guestbook-service.json
kubectl get services -o wide

## Delete a cluster

https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html

Note that the control plane alone cost 20c per hour

