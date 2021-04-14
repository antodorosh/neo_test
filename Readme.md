# Neotech Task Documentation

This file contains all answers and explanations regarding Neotech Test Task

================================================================

## 1st task

- Сreate Ansible role to manage redis+sentinel

> Please check **neo-ansible** folder.

- Install and configure redis and sentinel(should be able to setup 3 node redis+sentinel "master/slave")

> I have used role from the ansible-galaxy for that. In the case project not allowing to use ansible-galaxy roles, it can be created from scratch using ansible-galaxy role as a reference. 

>https://github.com/DavidWittman/ansible-redis

>https://galaxy.ansible.com/DavidWittman/redis

- Role should be idempotent

> By default most of the Ansible modules are idempotent. As far as I know, "shell" and "command" modules are not idempotent, but they are not used in the role.

- Role re-run should not brake cluster(keep in mind during redis+sentinel lifecycle master could be changed)

> As I am using galaxy role, this is covered by its creator. 

================================================================

## 2nd task

- Describe what common ci/cd stages should be used for successful, secure, bug-free application deployment. Tell us what ci/cd tools you would use to achieve desired results. Describe git-flow strategy.

> CI/CD stages: build, test, deploy


>CI/CD tools: I would use one of them: Jenkins, Cloudbees Jenkins (if there is a lot of customers which will use Jenkins), Gitlab CI. 
>Personally I liked to work with Gitlab + Gitlab CI.

>Automation tools: Ansible for configuration, Terraform for infrastructure deployment.

>Cloud: AWS

>Git strategy:

> - FEATURE branches are created by developers to work on the specific feature
>
> - DEV branch is used for development environment, developers are creating FEATURE branches from it to work on new features.
>
> - PREPROD/RC branch is used to be deployed on rc/preprod environment. Should not contain sensitive client data.
>
> - MASTER branch is used to be deployed to the actual prod environment. May contain sensitive client data. Must contain manual deployment trigger.

- Where to store and how to manage k8s resources - deployment, configmap, service, etc.

> Version controle software can be used to store code, plus AWS S3 buckets for the specific configs, like terraform .tfstate or  big amount of logs, configmap.


-  Where secrets and configs should be stored, how the application will get configs/secrets depending on the environment (dev/rc/prod)

> Secrets related to ansible deployments can be encrypted via ansible vault.
> There is an option to store secrets within AWS with Secret Manager or Hashicorp Vault

- How to implement image security patching? What tools are you planning to use? How the patching workflow would look like?

> For the security patching there should be  pipelines in CI/CD to perform it, we can use NEXUS for storing required packages.
> I am not very confident on this question, need to learn.

================================================================

# 3rd task

- Try to create pod by using next yaml

> Please take a look at **neotest.yml** It contains correct code and commentaries on what was changed.

- Why pod is not running? Provide correct Dockerfile. Use FROM neotechdev/nginx:v1 in your Dockerfile manifest.  

> Original .yml file was broken: indentation, values, etc.
>I inspected it, and resolved errors step by step.
>
> After fixing .yml, I build the pod in minicube - it's failing ("CrashLoopBackOff"), checked logs, saw several errors regarding nginx.conf file. 
>
> I deployed broken container, copied the original nginx.conf file from there found several issues: please take a look at **nginx.conf** it contains correct values and commentaries.
>
> After that I created an image based on provided neotech image, with correct nginx.conf and used this image to create a pod and test it in minikube. 


### Tools used:
- minikube
- docker
- ansible
- kubectl