<h1>Summary</h1>
The project utilizes AWS kubernetese service to deploy a web site.

[Website link](a1c583bb08b8b44a4ad83438fff3ccd9-1618222024.us-west-2.elb.amazonaws.com)
<h1> Files: </h1>

Dockerfile - Has the file required to dockerizing the flask app
requirements.txt - Has the required dependencies for the python app
create_eks_cluster.sh creates the EKS cluster. Cofigurations are read from eksctl-config.yml
app.py - Is the file that is the Flask
Makefile - Has set of commands to perform activities like install, lint, etc.,

<h1> How to run </h1>

Make sure minikube is installed. 

nstall Minikube
To run a Kubernetes cluster locally, for testing and project purposes, you need the Kubernetes package, Minikube. This operates in a virtual machine and so you'll need to download two things: A virtual machine (aka a hypervisor) then minikube. Thorough installation instructions can be found here. Here is how I installed minikube:

Install VirtualBox:

For Mac:

brew cask install virtualbox
For Windows, I recommend using a Windows host.

Install minikube:

For Mac:

brew cask install minikube
For Windows, I recommend using the Windows installer.

1. Start minikube
<pre><code>minikube start</pre></code>

2. Run Kubernetes
<pre><code>./run_kubernetes.sh</pre></code>

1. Once done,delete the minikube
<pre><code>minikube delete</pre></code>
