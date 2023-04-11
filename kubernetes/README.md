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
# Get commands with basic output
```kubectl get services                          # List all services in the namespace
kubectl get pods --all-namespaces             # List all pods in all namespaces
kubectl get pods -o wide                      # List all pods in the current namespace, with more details
kubectl get deployment my-dep                 # List a particular deployment
kubectl get pods                              # List all pods in the namespace
kubectl get pod my-pod -o yaml                # Get a pod's YAML  

# Describe commands with verbose output
kubectl describe nodes my-node
kubectl describe pods my-pod

# List Services Sorted by Name
kubectl get services --sort-by=.metadata.name

# List pods Sorted by Restart Count
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

# List PersistentVolumes sorted by capacity
kubectl get pv --sort-by=.spec.capacity.storage

# Get the version label of all pods with label app=cassandra
kubectl get pods --selector=app=cassandra -o \
  jsonpath='{.items[*].metadata.labels.version}'

# Retrieve the value of a key with dots, e.g. 'ca.crt'
kubectl get configmap myconfig \
  -o jsonpath='{.data.ca\.crt}'

# Get all worker nodes (use a selector to exclude results that have a label
# named 'node-role.kubernetes.io/master')
kubectl get node --selector='!node-role.kubernetes.io/master'

# Get all running pods in the namespace
kubectl get pods --field-selector=status.phase=Running

# Get ExternalIPs of all nodes
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'

# List Names of Pods that belong to Particular RC
# "jq" command useful for transformations that are too complex for jsonpath, it can be found at https://stedolan.github.io/jq/
sel=${$(kubectl get rc my-rc --output=json | jq -j '.spec.selector | to_entries | .[] | "\(.key)=\(.value),"')%?}
echo $(kubectl get pods --selector=$sel --output=jsonpath={.items..metadata.name})

# Show labels for all pods (or any other Kubernetes object that supports labelling)
kubectl get pods --show-labels

# Check which nodes are ready
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}' \
 && kubectl get nodes -o jsonpath="$JSONPATH" | grep "Ready=True"

# Output decoded secrets without external tools
kubectl get secret my-secret -o go-template='{{range $k,$v := .data}}{{"### "}}{{$k}}{{"\n"}}{{$v|base64decode}}{{"\n\n"}}{{end}}'

# List all Secrets currently in use by a pod
kubectl get pods -o json | jq '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq

# List all containerIDs of initContainer of all pods
# Helpful when cleaning up stopped containers, while avoiding removal of initContainers.
kubectl get pods --all-namespaces -o jsonpath='{range .items[*].status.initContainerStatuses[*]}{.containerID}{"\n"}{end}' \
| cut -d/ -f3

# List Events sorted by timestamp
kubectl get events --sort-by=.metadata.creationTimestamp

# Compares the current state of the cluster against the state that the cluster would be in if the manifest was applied.
kubectl diff -f ./my-manifest.yaml

# Produce a period-delimited tree of all keys returned for nodes
# Helpful when locating a key within a complex nested JSON structure
kubectl get nodes -o json | jq -c 'path(..)|[.[]|tostring]|join(".")'

# Produce a period-delimited tree of all keys returned for pods, etc
kubectl get pods -o json | jq -c 'path(..)|[.[]|tostring]|join(".")'

# Produce ENV for all pods, assuming you have a default container for the pods,
# default namespace and the `env` command is supported.
# Helpful when running any supported command across all pods, not just `env`
for pod in $(kubectl get po --output=jsonpath={.items..metadata.name}); do echo $pod && kubectl exec -it $pod env; done

```

### POD Logs Cheat sheet 

1. Print the logs for a pod  
	```kubectl logs <pod_name>```
2. Print the logs for the last 6 hours for a pod  
	```kubectl logs --since=6h <pod_name>```
3. Get the most recent 50 lines of logs for a pod  
	```kubectl logs --tail=50 <pod_name>```
4. Print the logs for a pod and follow new logs  
	```kubectl logs -f <pod_name>```
5. Print the logs for a container in a pod  
	```kubectl logs -c <container_name> <pod_name>```
6. Output the logs for a pod into a file named 'pod.log'  
	```kubectl logs <pod_name> > pod.log```
7. View the logs for a previously failed pod  
	```kubectl logs --previous <pod_name>```
8. View the logs for all containers in a pod  
	```kubectl logs <pod_name> --all-containers```


## What are the types of Kubernetes services?  
• **ClusterIP**: Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the cluster. This is the default that is used if you don't explicitly specify a type for a Service.  
• **NodePort**: Exposes the Service on each Node's IP at a static port (the NodePort). To make the node port available, Kubernetes sets up a cluster IP address, the same as if you had requested a Service of type: ClusterIP.  
• **LoadBalancer**: Exposes the Service externally using a cloud provider's load balancer.  
ExternalName: Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up.


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


### Useful Links
https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro  
https://kubernetes.io/docs/concepts/services-networking/service/  
https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/  
https://minikube.sigs.k8s.io/docs/handbook/accessing/#example-of-loadbalancer  
https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress  
https://traefik.io/glossary/kubernetes-ingress-and-ingress-controller-101/  
https://kubernetes.io/docs/reference/kubectl/cheatsheet/  
