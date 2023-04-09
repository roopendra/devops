# Kubernetes Reference
Kubernetes is a portable, extensible, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation.

## Why you need Kubernetes and what it can do  
Containers are a good way to bundle and run your applications. In a production environment, you need to manage the containers that run the applications and ensure that there is no downtime. For example, if a container goes down, another container needs to start. Wouldn't it be easier if this behavior was handled by a system?

That's how Kubernetes comes to the rescue! Kubernetes provides you with a framework to run distributed systems resiliently. It takes care of scaling and failover for your application, provides deployment patterns, and more. For example: Kubernetes can easily manage a canary deployment for your system.

#### Kubernetes provides you with:

**Service discovery and load balancing** Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.  
**Storage orchestration** Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.  
**Automated rollouts and rollbacks** You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.  
**Automatic bin packing** You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.   
**Self-healing** Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.   
**Secret and configuration management** Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.

## Kubernetes Basic Terms and Concepts
#### Nodes
Nodes are the machines on Kubernetes. They can be either a physical or a virtual machine.
#### Namespace
Namespaces isolate different groups of resources. They avoid name collisions by scoping the visibility of your resources.
#### Pods
Pods are the fundamental compute unit in Kubernetes. Pods are composed of a group of one or more containers, the shared storage for them and their options.
#### Deployments
Deployments are used to make updates on Pods. We can use them to bring up new Pods, change the image version of a container and even recreate the previous state if something goes wrong.
### Services
Service consist of a set of Pods and a policy that defines the access control. It is responsible for managing, deploying and operating containers integrates easily with other services.
### ReplicaSets
ReplicaSets are used to consistently replicate a Pod. They provide a guarantee that a set number of replicas will be running at any time. If a node goes offline or a Pod becomes unhealthy, Kubernetes will automatically schedule a new Pod instance to maintain the specified replica count.

### Volumes
Volumes mount external filesystem storage inside your Pods. They abstract away the differences between different cloud providers’ storage implementations.

Volumes can and shared between your Pods. This allows Kubernetes to run stateful applications where data must be preserved after a Pod gets terminated or rescheduled. You’ll need to use a volume whenever you’re running a database or file server in your cluster.

### Secrets and ConfigMaps
Secrets are used to inject sensitive data into your cluster such as API keys, certificates, and other kinds of credential. They can be supplied to Pods as environment variables or files mounted into a volume.

ConfigMaps are a similar concept for non-sensitive information. These objects should store any general settings your app requires.
## Kubernetes Architecture
![image](https://user-images.githubusercontent.com/1461161/230776270-189b6c64-658a-4bec-993e-9fbcd650700d.png)

https://kubernetes.io/docs/concepts/overview/components/
### What are role of master and data nodes in Kubernetes ?

![image](https://user-images.githubusercontent.com/1461161/230360777-1a92f70c-c90d-42eb-bdbb-4b3e08e63388.png)

![image](https://user-images.githubusercontent.com/1461161/230360810-3bd820af-eaf7-4f43-83da-efa2326410c0.png)
 
## Minikube 
minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes. All you need is Docker (or similarly compatible) container or a Virtual Machine environment, and Kubernetes is a single command away: minikube start

**What you’ll need**
- 2 CPUs or more  
- 2GB of free memory  
- 20GB of free disk space  
- Internet connection  
- Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
1Installation
     
 **For Windows:**
 I would recommend to install Docker Desktop as setup is easy. 
 https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
 
 For more details, you can check here: https://docs.docker.com/desktop/install/windows-install/
  
 **For Mac:**
 Please refer this page : https://docs.docker.com/desktop/install/mac-install/
 
  Ensure you install any of the tool before you start with Minikube installation.

## Installation

First, go to https://minikube.sigs.k8s.io/docs/start/ and select the appropriate OS and other OS-specific parameters. You will get the installation commands for the specific OS as shown below.

**For Windows**  - Download exe from below link and install it.  
https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe   
**For Mac***   If the Homebrew Package Manager is installed:  
>brew install minikube  

## Minikube Common Issues
1. X Exiting due to PROVIDER_DOCKER_NOT_RUNNING: deadline exceeded running "docker version --format -:": exit status 1  
*Solution*: Before executing `minikube start` command make sure Docker service is running.  

**Start your cluster**
```
minikube start
```

**POD**  
- Create pod 
- List pod 
- Access pod
- Delete Pod 
```
$ kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
pod/nginx created

$ kubectl get pods
NAME      READY     STATUS              RESTARTS   AGE
nginx     0/1       ContainerCreating   0          9s

$ winpty kubectl exec -it nginx bash
root@nginx:/# exit
exit

$ kubectl delete pod nginx
pod "nginx" deleted
```

**Impreative method to create Deployment**
```
$ kubectl create deployment nginx --image=nginx
deployment.apps/nginx created

$ kubectl scale --replicas=2 deployment/nginx
deployment.apps/nginx scaled

$ kubectl get deployments
NAME      READY     UP-TO-DATE   AVAILABLE   AGE
nginx     2/2       2            2           11s

$ kubectl get pods
NAME                     READY     STATUS    RESTARTS   AGE
nginx-6799fc88d8-5srtz   1/1       Running   0          11s
nginx-6799fc88d8-v9q74   1/1       Running   0          16s

$ kubectl delete deployment nginx
deployment.apps "nginx" deleted

```

## Scaling and Autoscaling ReplicaSets

```
#Create pod with a label that match ReplicaSets
~/devops/kubernetes (master)
$ kubectl apply -f demo-web.yaml
pod/demo-web created

# Check if pod is running or not
~/devops/kubernetes (master)
$ kubectl get pods
NAME       READY     STATUS    RESTARTS   AGE
demo-web   1/1       Running   0          18s

# Create ReplicaSets with 4 replicas
~/devops/kubernetes (master)
$ kubectl apply -f nginx_replicaset.yaml
replicaset.apps/web created

# Check the numnber of pods running. 
# As 1 pod was running so ReplicaSets only created 3 pods
~/devops/kubernetes (master)
$ kubectl get pods
NAME        READY     STATUS    RESTARTS   AGE
demo-web    1/1       Running   0          71s
web-6t2ps   1/1       Running   0          13s
web-jqwmp   1/1       Running   0          13s
web-n7w22   1/1       Running   0          13s

# Delete demo-web pod
~/devops/kubernetes (master)
$ kubectl delete pods demo-web
pod "demo-web" deleted

# ReplicaSets will automatically create missing pod. 
~/devops/kubernetes (master)
$ kubectl get pods
NAME        READY     STATUS    RESTARTS   AGE
web-6t2ps   1/1       Running   0          80s
web-jqwmp   1/1       Running   0          80s
web-n7w22   1/1       Running   0          80s
web-qk4zz   1/1       Running   0          12s

#List all ReplicaSets
~/devops/kubernetes (master)
$ kubectl get rs
NAME      DESIRED   CURRENT   READY     AGE
web       4         4         4         2m49s

# Delete ReplicaSets
~/devops/kubernetes (master)
$ kubectl delete rs web
replicaset.apps "web" deleted

# Validate if pods delete or not
~/devops/kubernetes (master)
$ kubectl get pods
No resources found.
```

## What are the types of Kubernetes services?
[image](https://user-images.githubusercontent.com/1461161/230776043-8e436797-2e2b-466b-9f7c-62775583156c.png)



## What is Ingress? 
https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress  
Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

Here is a simple example where an Ingress sends all its traffic to one Service:

![image](https://user-images.githubusercontent.com/1461161/230775925-e438889e-499e-4648-a903-919e63a5e922.png)

An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting. An Ingress controller is responsible for fulfilling the Ingress, usually with a load balancer, though it may also configure your edge router or additional frontends to help handle the traffic.

An Ingress does not expose arbitrary ports or protocols. Exposing services other than HTTP and HTTPS to the internet typically uses a service of type Service.Type=NodePort or Service.Type=LoadBalancer.

## Ingress Controllers
In order for the Ingress resource to work, the cluster must have an ingress controller running.

Unlike other types of controllers which run as part of the kube-controller-manager binary, Ingress controllers are not started automatically with a cluster. Use this page to choose the ingress controller implementation that best fits your cluster.

Kubernetes as a project supports and maintains AWS, GCE, and nginx ingress controllers  
https://www.nginx.com/products/nginx-ingress-controller/
https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/


