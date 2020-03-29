# Blog

## Steps to reproduce

0) Documentation template project import
1) Create initial network resources:

- VPC
- Subnets & AZ assignment
- TF Providers, random string generator, variables w/ defaults

2) `tf init`
3) `tf apply --auto-approve`
4) Confirm resources created in AWS console
5) Add lambda in the private subnet
