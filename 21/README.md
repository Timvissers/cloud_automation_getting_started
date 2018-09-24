# DOCKER + AWS OPTIONS

https://medium.freecodecamp.org/an-in-depth-introduction-to-docker-on-aws-f373ff97da0e: in depth choices

https://medium.com/devopsion/5-ways-of-using-docker-on-aws-7d91b31caddc: decisions, decisions, decisions

## AWS IAAS diy with docker + any orchestrator (swarm, kubernetes,...) installed

- docker, swarmkit, docker stack, might be good for testing: https://medium.com/@cjus/installing-docker-ce-on-an-aws-ec2-instance-running-ubuntu-16-04-f42fe7e80869

- example using docker machine, docker compose, docker swarm, good for testing: https://github.com/tomwillfixit/swarm-test-cluster

## ECS, elimates the need to install and operate an other orchestration service, possibly with Fargate option (no need to provision and manage clusters)

- https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html

## AWS Elastic Beanstalk on ECS

- https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker.html

## EKS (Kubernetes orchestrator, without having to manage servers and clusters, as ECS)

https://fortyft.com/posts/elastic-beanstalk-vs-ecs-vs-kubernetes/

    TODO

## Docker CE for AWS

https://docs.docker.com/docker-for-aws/

## Docker datacenter

https://s3.amazonaws.com/quickstart-reference/docker/latest/doc/docker-datacenter-on-the-aws-cloud.pdf

## AWS CloudFormation + Docker for AWS service

a working swarm cluster

https://www.infoworld.com/article/3145696/application-development/docker-for-aws-whos-it-really-for.html

https://medium.com/@lherrera/docker-for-aws-preview-29c1b34c54d3

    TODO

## Docker cloud (hosted not on your infrastructure)

https://docs.docker.com/docker-cloud/getting-started/

    TODO


