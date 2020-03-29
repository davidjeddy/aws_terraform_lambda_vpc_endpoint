# Blog

Using VPC endpoints removed the need to use a NAT and traverse the public internet to read other services such as SQS, SNS, SES, etc. This saves network travel time, bandwidth costs, and increases security.

## How To

### Init Setup

0) Load dsocumentation template project import
1) Create initial network resources:

- VPC
- Subnets & AZ assignment
- TF Providers, random string generator, variables w/ defaults

2) INIT Terraform
3) `tf apply --auto-approve`
4) Confirm resources created in AWS console

### Add private lambda

1) Add lambda module in the private subnet

- Python 3.7 based, very simple
- ADDED `ec2:...` permissions to allow the lambda to create and attach a ENI.
- (optional) ADDED ClkoudWatch logs for logging view


2) Add the new lambda module via `tf init`
3) Create lambda via `tf plan` and then `tf apply`
4) Verify Lambda creation
5) Execute a `test` invokation via the web console

### Add SQS

1) Create SQS queue
2) Confirm queue exists via web console
3) Updated private lambda permissions to allow access to queue

### ADD public lambda

### Add VPC endpoint for SQS queue

### Configure private lambda to ouput to SQS Endpoint

### Confirm End-to-End execution


## Additional Sources

- https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-sending-messages-from-vpc.html
- https://medium.com/tensult/creating-vpc-endpoint-for-amazon-s3-using-terraform-7a15c840d36f
