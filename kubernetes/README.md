# Kubernetes Reference
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
 I would recommend to install Doeker Desktop as setup is easy. 
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

**Start your cluster**
```
minikube start
```
