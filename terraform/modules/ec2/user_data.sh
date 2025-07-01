#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Login to ECR
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com

# Pull and run Docker container
docker pull ${ecr_repo_url}
docker run -d -p 3000:3000 ${ecr_repo_url}