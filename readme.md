# Cloud Native - Practical Project - Jonathan Hunt
##  Introduction

In this project, a variety of DevOps tools will be used to deploy a web app via Amazon Web Services (AWS). 
This project makes use of:

 - Terraform
 - Ansible
 - Jenkins
 - Docker
 - Kubernetes
 - Amazon Web Services

Using these tools, an app is deployed to the web that is accessible from anybody on the web. The following readme will show you how to configure this website yourself from the repositories linked below. Please note, **some confidential information such as IP adresses, RDS addresses, usernames and passwords have been removed and your own must be created in order for this app to work**.


*Presentation available at: https://drive.google.com/file/d/1mtSUbeOptM5oYsvYNov3_acyDaXRVITo/view?usp=sharing*
*Jira Board available at:*


## Git Repositories
The project is split across two git repositories. This is to keep unnecessary files from being loaded into the project VM's. 

**The first repository can be found here:**
[Github - Setup Files - Terraform and Ansible](https://github.com/jonathanjhunt/Ci_Cd_Project)

 *This git repository contains the files for terraform and ansible. This is the repository that you will need to clone in order to begin setting up this project.*

**The second repository can be found here:**
[Gitlab - Project Files - Kubernetes, Docker and Jenkins](https://gitlab.com/jonathan.j.hunt/cne-sfia2-brief)
*This repository contains all of the project files. Although you do not need to manually clone this repository,* **some files** *will need to be changed in order for this to work. Therefore you will need to fork this repository to your own account so you can make the changes.*

# Tutorial
This tutorial will show you how to setup this working web-app. Please note that some AWS services used in this tutorial are **paid services**.

## Prerequisites
In order to begin the setup of this web-app you **must have  both ansible, terraform and awscli installed on your own ubuntu device/VM.**

You must also have an AWS account set up with **programatic access**.
## Cloning the project files.

 1. Fork the repository from [here](https://github.com/jonathanjhunt/Ci_Cd_Project) to your own account and clone the repo to your own device/VM.

## Configure AWSCLI

AWSCLI is the software that connects all of your terraform commands to your amazon web account and will allow you to manage the web infrastructure you create using terraform.

 1. Log-in using the command
 

    >aws configure
 2. Using your aws credentials, connect your machine to your account.

## Terraform

Terraform will efficiently build and faciliate almost all of the web infrastructure required to build your web-app. There is **one file missing** which must be entered manually. This is due to the file containing sensitive data that couldnt be posted to the git repository. To ammend this, do the following:
1. Navigate to the repository and create the file

    >cd ~/Ci_Cd_Project/CN_Project/Terraform/RDS
    sudo touch variables.tf
    sudo vim variables.tf
2. Paste the following into the file

	> variable "DB_USER" {
  description = "name of user"
  default     = "**USERNAME**"
}
variable "DB_PASSWORD" {
  description = "password for db"
  default     = "**password**"
}
variable "subnet1_id" {
  description = "to be replaced"
}
variable "subnet2_id" {
  description = "to be replaced"
}
variable "vpc_security_group_ids" {
  description = "SG to be override"
}

Here **you must replace** the username and password to something memorable. 

**Additionally, you must also create your own PEM key using AWS services and change the name of the key in /ec2/variables.tf to the name of your own key.**

	

> variable  "pem-key"  {
description  =  "pem-key"
default  =  "**JonathanQA**"
}

Replace "JonathanQA" with the name of your own file.

Now, you will be able to begin the build.

3. Navigate to the root terraform directory and initialise terraform:
	> cd Ci_Cd_Project/CN_Project/Terraform
	terraform init


4. Plan the build to ensure the files are formatted correctly and check the build is correct.
	> terraform plan
5. Begin the build
	> terraform apply

![enter image description here](https://i.imgur.com/Hhw5EiL.png)
The build should take approximately 5 minutes with the RDS tables being the last to complete.

## Amazon EKS

Amazone EKS is the kubernetes cluster service that is available through AWS. **This is a paid service** and will cost to run. You must also have a Cluster Service Role and Node IAM Role configured to complete the setup.

To configure this, log in to the AWS Console and navigate to EKS. 
1. Click create cluster and configure as follows, then click next.
![enter image description here](https://i.imgur.com/j26P6cD.png)

2. Assign the VPC to 'Production', you should see the subnets change. Assign security group to 'webserver':
![enter image description here](https://i.imgur.com/bdsDAD4.png)
3. Skip logging and create the cluster. (This will take approximately 15 minutes)

4. Navigate into your cluster, then to the 'compute' tab and select "add node group". Give it a name, select the Node IAM Role you have created and continue.
5. Configure as follows and **create**
![enter image description here](https://i.imgur.com/rfj51CC.png)

## Ansible

Ansible is a flexible DevOps tool that allows for multiple software installs on multiple machines via SSH with one command. In this project, you will use ansible to install the required software(s) for the web app to work. 
1. First, log in to you AWS console and collect the IP's of both the Test VM and Jenkins VM. On your own ubuntu machine, navigate to:

	>/etc/ansible
	sudo vim hosts
2.  Add the following code with your own IP's to allow Ansible to ssh into the machines and install the required software.
	>[jenkins_kubernetes]
ubuntu@**jenkins-ip** ansible_ssh_private_key_file=/etc/.ssh/JonathanQA.pem
[docker_testing]
ubuntu@**test-ip** ansible_ssh_private_key_file=/etc/.ssh/JonathanQA.pem

3. navigate to:

	> /Ci_Cd_Project/CN_Project/Ansible/build.yaml
4. Ensure that you have the pem key you configure in the terraform steps on your local machine and replace the location of the .pem file in the build.yaml. There should be two places it needs changing as there are two machines. 

	> name:  copying pem key to jenkins machine
become:  yes
template:
src:  /etc/.ssh/JonathanQA.pem
dest:  /home/ubuntu/JonathanQA.pem
owner:  ubuntu
group:  ubuntu

5. run:
	> ansible-playbook build.yaml

## Manual Processes
The next stages are manual processes that must be completed in order for the future steps to work. The reason for most of these steps is to **ensure security** as these files are on a public repository. Additionally, you will need to configure several IP's to match your own. From now on, where you see a change in IP, it will need to be changed manually from **your own forked gitlab repository (repo 2)**.

1.  ssh into the **test-vm** and navigate to 
	> /etc
	sudo vim environment

Navigate to RDS on the AWS console and find the address for each of your databases.
In 'environment, paste the following, replacing all the credentials and URI's with your own:
	
>TEST_DATABASE_URI="mysql+pymysql://DBUSERNAME:DBPASSWORD@TEST_DB_URI:3306/testdb"
		DATABASE_URI="mysql+pymysql://DBUSERNAME:DBPASSWORD@DB_URI:3306/users"

2. In the gitlab repository, go through every file and replace the IP addresses with your own for both Jenkins and Test VM.
3. SSH into the test vm from the jenkins machine, this is required to confirm authentication. It cannot be done automatically.
4. Log in to your docker account on the test VM and change the username in the dockerfiles and push_to_docker script to your own.
5. Configure aws credentials on Jenkins VM.
6. Using the following command, log in to each database, and then copy the text from the Create.mysql in the project git repository. This will configure the databases ready for operation
	>mysql -h endpoint_url -u username -p password
7. On the jenkins vm, link the machine to the cluster you have created using the following command:
	> aws eks --region **Cluster Region** update-kubeconfig --name **Cluster Name**
## Jenkins
Jenkins is the DevOps tool that will be used to build, test and deploy the web-app.  Like many of the other tools used in this project, it is an incredibly versatile piece of software however some of its main uses will be demonstrated in this project.

1. Find your Jenkins **public IP** and access it at port 8080, eg:
	>https://jenkins-ip:8080

2. To log-in, you will need the administator password. This can be found at:
	> Ci_Cd_Project/CN_Project/Ansible/returns/**your-jenkins-vm**/jenkins/.jenkins/secret/initialAdminPassword

3. Once you have logged in, install all necessary plugins and click "new project".
4. Select Pipeline.
5. Scroll down to pipeline and configure as follows
![enter image description here](https://i.imgur.com/sHPrZpH.png)

Replace "your-gitlab-account" with your username.

Once this is done.......

**HIT BUILD!!!**
## Lets have a look whats been made......

Navigate to your jenkins vm and type the following into the terminal.

	kubectl get service -n project
Here you will see an external IP.  Copy this and navigate to it in your web-browser.
![enter image description here](https://i.imgur.com/Z2m6FbQ.png)

You have now successfully launched a web-app using the following tools:
 - Terraform
 - Ansible
 - Jenkins
 - Docker
 - Kubernetes
 - Amazon Web Services

# About the Author

![Jonathan Hunt MEng](https://i.imgur.com/7Bp0a8z.jpg)

I am a cloud-native developer for QA Consulting. My technical developer skills include:
|  Technology Domain|Technologies and Tools  |
|--|--|
|  Programming Languages| Java, HTML, CSS, JavaScript, Python, MatLab, GCODE |
| IDE's| Eclipse, Visual Studio Code, Pycharm |
|  Operating Systems| Windows, Linux (Ubuntu), Mac OS |
|  DevOps Technologies| Git, Jenkins, Ansible, Terraform, Docker, Kubernetes |
|  Cloud Platforms| GCP, AWS |
|  Database Technologies|  MYSQL, H2|
|  Other|Agile Scrum, Waterfall, Postman, Junit, Spring Boot, Maven  |

## Acknowledgements
- Kubernetes: https://kubernetes.io/
- Terraform: https://www.terraform.io/
- AWS: https://aws.amazon.com/
- Jira: https://www.atlassian.com/software/jira
- Jenkins: https://www.jenkins.io/
- Docker: https://www.docker.com/


