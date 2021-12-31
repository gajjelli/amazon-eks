#! /bin/bash

echo "install aws cli.."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install &

echo "install terraform .."
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

echo "install kubectl .."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

echo "execute terraform init, plan & apply ....."
terraform init --auto-approve &
terraform plan --auto-approve &
terraform apply --auto-approve &
sleep 1200;

echo "update aws config ~/.kube/config"
aws eks --region eu-west-1 update-kubeconfig --name aws-eks

echo "update aws-auth configmap for 'developer' userarn with RBAC roles"
##  Copy the user arn from local-output-files/pdb_policy_arn.txt and update  aws-auth.yaml as below


# sed  '/\data:/a mapUsers: |
#  - userarn: arn:aws:iam::<aws-account-id>:user/developer
#    username: developer
#    groups:
#      - reader' k8s-manifests/aws-auth-template0.yaml

kubectl get -n kube-system configmap/aws-auth >> aws-auth.yaml
