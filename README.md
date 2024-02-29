# Project-3---Kubernetes-EKS
Project: Operationalizing a Coworking Space Microservice

### Dependencies
#### Local Environment
1. Python Environment - run Python 3.6+ applications and install Python dependencies via `pip`.
2. Docker CLI - build and run Docker images locally
3. `kubectl` - run commands against a Kubernetes cluster
4. `helm` - apply Helm Charts to a Kubernetes cluster

#### Remote Resources
1. AWS CodeBuild - build Docker images remotely
2. AWS ECR - host Docker images
3. Kubernetes Environment with AWS EKS - run applications in k8s
4. AWS CloudWatch - monitor activity and logs in EKS
5. GitHub - pull and clone code


### Setup
#### 1. Configure a Database
Set up a Postgres database using a Helm Chart.

relate the cluster to local env
```aws eks --region us-east-1 update-kubeconfig --name demo```

```bash
helm repo add <REPO_NAME> https://charts.bitnami.com/bitnami
```




