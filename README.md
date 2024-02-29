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
```
aws eks --region us-east-1 update-kubeconfig --name demo
```
Setup Repo
```
helm repo add gk-demo-postgres https://charts.bitnami.com/bitnami
```
Install PostgreSQL Helm chart
```
helm install gk-demo-postgres gk-demo-postgres/postgresql --set primary.persistence.enabled=false --set global.storage=local-storage
```
Get password for our db
```
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default gk-demo-postgres-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

echo $POSTGRES_PASSWORD
```

Connect to PostgreSQL server via port forwarding
```
kubectl port-forward --namespace default svc/gk-demo-postgres-postgresql 5432:5432
```

Then connect to the local host IP via a Postgre Client and run the SQL files provided to setup the tables and data

With the DB set now, 

We can run the given app in the local machine and check the code if it is working. Corrected few syntaxes and added a python model for Token used in the code. 
Updated the requirements file to meet our application requirements.

Then, create a buildspec.yml and update in repository to create a pull request for AWS codebuild (already setup) to pull our code and create an image in ECR. Semantic versioning of Image tag was used for the images. 

with our image ready in ECR, created the deployment files for EKS 
  - app deployment with the ECR image pointed.
  - DB deployment with our PostgreSQL pointed
  - DB credentials given in the db-secret file
  - Also, setup our node group to have sufficient nodes for our POD deployment. 
  - Setup IAM role for node group appropriate so that we can use Cloudwatch for logs - add this policy `CloudWatchAgentServerPolicy`

After the deployments,
used `kubectl get pods`, `kubectl get svc`, `kubectl describe pod <podname>`, `kubectl logs <podname> -c <containername>` to check and fix the few teething issues during inital deployments. 

use `kubectl delete` to delete the resources after the project.

### Stand Out Suggestions
1.  Used t3.medium for AWS instance type - as it would cater to the requirements of this deployment. It provides good combination of memory and CPU power required. 
2.  For cost-saving, used desired and minimum number of nodes carefully so that the resources are just enough for the application to run without issues.
3.  Monitoring the usage for controlling the costs and understand the usage of the app. Checking the logs of apps for any problems and troubleshooting. 





