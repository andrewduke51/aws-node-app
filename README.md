# aws-node-app

# Requirements
1. An aws account.
2. A circleci account.
3. t2.micro ec2 instance.
4. A container repository.
5. Install terraform, packer, ansible and Docker
6. optional: a dns name to reach your weather website.

1. If you want to run this pipeline. Please submit a pull request with you feature update branch.
2. If you need to setup your environment with the following workflow variables to use your CI/CD.
   * YOUR_VPC_ID
   * YOUR_SUBNET_ID
   * YOUR_AWS_ACCESS_KEY_ID
   * YOUR_AWS_SECRET_ACCESS_KEY
   * YOUR_DOCKERHUB_USERNAME
   * YOUR_DOCKERHUB_PASSWORD