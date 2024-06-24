# bastion_host_rds_tf
Deployment example of how to deploy a bastion host and aws rds.



aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
chmod 400 MyKeyPair

terraform init

terraform plan -out=plan \
-var="region=${REGION}" \
-var="deployment_name=${DEPLOYMENT_NAME}" \
-var="db_password=${DB_PASSWORD}" \
-var="db_username=${DB_USERNAME}" \
-var="ec2_key_pair_name=${EC2_KEY_PAIR}"

terraform apply plan


# Clear down

terraform plan -out=plan -destroy \
-var="region=${REGION}" \
-var="deployment_name=${DEPLOYMENT_NAME}" \
-var="db_password=${DB_PASSWORD}" \
-var="db_username=${DB_USERNAME}" \
-var="ec2_key_pair_name=${EC2_KEY_PAIR}"

terraform apply plan
