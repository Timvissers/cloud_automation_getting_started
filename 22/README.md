# Docker for AWS + SWARMKIT

docker for aws:

https://docs.docker.com/docker-for-aws/#configuration

https://www.youtube.com/watch?v=jKrLAwDN7uY

swarm:

https://docs.docker.com/engine/swarm/#whats-next

https://docs.docker.com/engine/swarm/admin_guide/

## case: jenkins on docker for aws with swarm

### Setup docker for AWS

https://www.youtube.com/watch?v=uWTL8gwzZz4

CloudFormation URL for docker CE for aws:

https://eu-central-1.console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=Docker&templateURL=https:%2F%2Feditions-us-east-1.s3.amazonaws.com%2Faws%2Fstable%2FDocker.tmpl

- stack name: CAGSdockerForAWS
- 3 managers, 3 workers

- outputs

        - DefaultDNSTarget: CAGSdocke-External-FKUCXRG8FXKB-1057194120.eu-central-1.elb.amazonaws.com: to interact with the cluster through a browser
        - Managers: https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#Instances:tag:aws:autoscaling:groupName=CAGSdockerForAWS-ManagerAsg-STJDKBGGUWKK;sort=desc:dnsName
            - one of the managers public IP: 35.158.161.73

- connect

        export CLUSTER_DNS=CAGSdocke-External-FKUCXRG8FXKB-1057194120.eu-central-1.elb.amazonaws.com
        export CLUSTER_IP=35.158.161.73
        ssh -i cloud_automation_getting_started.pem docker@$CLUSTER_IP

- sample commands

        docker node ls

If one of the managers goes down or fails the built-in health checks, a new node will be generated

### setup swarm with jenkins

https://technologyconversations.com/2017/08/03/jenkins-master-as-a-docker-service-running-inside-a-docker-for-aws-cluster/

https://gist.github.com/vfarcic/a37504518f3564a1e9772143bd620415

#### attempt 1: just run a container using 'docker container run -d'

        docker container run -d --name jenkins -p 8080:8080 jenkins:alpine

- problem: no high availability:

        if a container goes down (or a process went down and the container stops), our service is not available
        if the whole machine goes down, our service is not available any more

- problem: no fault tolerance

        no scheduler, or scheduler cannot reschedule when node goes down

#### attempt 2: run a service

        docker service create --name jenkins -p 8080:8080 jenkins:alpine
        docker service ps jenkins

Swarm is doing it in the backend. It gives a service id

- orchestration/scheduling: no control on which node a replica of a service is running

- problem: remember few arguments of creating a service

#### attempt 3: run a stack

        docker stack deploy -c jenkins.yml jenkins

stack: collection of services

        version: '3'

        services:

          main:
            image: jenkinsci/jenkins:${TAG:-lts-alpine}
            ports:
              - ${UI_PORT:-8080}:8080
              - ${AGENTS_PORT:-50000}:50000
            environment:
              - JENKINS_OPTS="--prefix=/jenkins"

create a network network_default + a service jenkins_main

        docker stack ps jenkins

- problem: port 8080 is silly. DNS like 'jenkins.mycomp.com'. We want to remove the port and add a proxy

#### attempt 4: add a proxy (docker flow proxy)

a new stack

containing

- modified proxy: dynamic proxy that listens to swarm events and auto configures itself
https://proxy.dockerflow.com/

- a swarm listener
https://proxy.dockerflow.com/

        version: "3"

        networks:

          proxy:
            external: true

        services:

          proxy:
            image: dockerflow/docker-flow-proxy:${TAG:-latest}
            ports:
              - 80:80
              - 443:443
            networks:
              - proxy
            environment:
              - LISTENER_ADDRESS=swarm-listener
              - MODE=swarm
              - CONNECTION_MODE=${CONNECTION_MODE:-http-keep-alive}
            deploy:
              replicas: 3

          swarm-listener:
            image: vfarcic/docker-flow-swarm-listener
            networks:
              - proxy
            volumes:
              - /var/run/docker.sock:/var/run/docker.sock
            environment:
              - DF_NOTIFY_CREATE_SERVICE_URL=http://proxy:8080/v1/docker-flow-proxy/reconfigure
              - DF_NOTIFY_REMOVE_SERVICE_URL=http://proxy:8080/v1/docker-flow-proxy/remove
            deploy:
              placement:
                constraints: [node.role == manager]

execute

        docker network create -d overlay proxy

        docker stack deploy -c proxy.yml proxy

and the modified jenkins stack

        version: '3'

        services:

          main:
            image: jenkinsci/jenkins:${TAG:-lts-alpine}
            ports:
              - "50000:50000"
            environment:
              - JENKINS_OPTS="--prefix=/jenkins"
            networks:
              - proxy
            deploy:
              labels:
                - com.df.notify=true
                - com.df.distribute=true
                - com.df.servicePath=/jenkins
                - com.df.port=8080

        networks:
          proxy:
            external: true

the proxy is informed with the path and port inside the container (see the labels)

        docker stack deploy -c jenkins.yml jenkins

#### Remove manual setup for jenkins

Using a custom jenkins image. The default images requires us to do some stuff: setting admin user/pass, configure plugins, etc.

Baked into an image:

- no setup wizard

- default users, through a groovy file and *secrets*

- set of plugins, through a file

This results in a new stack

#### Attempt 5: add fault-tolerance by preserving state

problem: recover from failure is not working. Swarm detects the failure, and swarm will reschedule it on a node.

simulation: shut down jenkins url -> simulate failure (process stops)

result: jenkins state is lost

solution: Jenkins uses file-system to store its state. We use EFS

2 volumes

        jenkins master 'named volume', maps to /var/jenkins_home, this contains the whole state

        jenkins master share 'named volume': special directory: all content will be initialized by jenkins


        ...
        volumes:
          jm:
            driver: cloudstor:aws
            external: false
          jmshare:
            driver: cloudstor:aws
            external: false

Add memory reservation and memory limits

Now, it will be fault-tolerant, after simulating failure again












## services offered by docker swarm

TODO

why: https://rominirani.com/docker-swarm-tutorial-b67470cf8872

what: https://github.com/docker/swarmkit

what: https://semaphoreci.com/community/tutorials/scheduling-services-on-a-docker-swarm-mode-cluster

comparison: https://www.weave.works/blog/docker-swarm-vs-kubernetes/


## shortcomings of this setup

TODO

only for stateless applications (no storage)? https://blog.thecodeteam.com/2017/02/09/persistent-storage-docker-aws-not-a-mystery/

how about: https://docs.docker.com/docker-for-aws/persistent-data-volumes/#list-or-remove-volumes-created-by-cloudstor

deprecated: docker EE for aws is already deprecated in favor of docker certified infrastructure for aws



