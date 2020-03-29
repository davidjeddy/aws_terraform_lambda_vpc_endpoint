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


### Add SQS

1) Create SQS queue (and dead letter queue for unprocessable messages)
2) Confirm queues exists via `aws sqs list-queues` CLI command

### Add private lambda

1) Add lambda module in the private subnet

- Python 3.7 based, code sourced from resource
- Add `ec2:...` permissions to allow the lambda to create and attach an ENI
- (optional) Add CloudWatch logs permissions

2) Add the new lambda module via `tf init`
3) Create lambda via `tf plan` and then `tf apply`
4) Verify Lambda creation
5) Execute a `test` invokation via the web console

```json
{
  "key1": "value1",
  "key3": "value10",
  "key5": "value100"
}
```

### ADD public lambda

1) Add lambda w/o vpc_config option

- Python 3.7 based, very simple
- DO NOT allow EC2:ElasticInterface* permissions
- Change permissions to allow sqs:message* read and delete
- (optional) Add CloudWatch logs permissions

2) Add the new lambda module via `tf init`
3) Create lambda via `tf plan` and then `tf apply`
4) Verify Lambda creation
5) Execute a `test` invokation via the web console

```json
{
  "key1": "value1",
  "key3": "value10",
  "key5": "value100"
}
```

6) Add configuration to subscribe Lambda to SQS queue
7) Confirm configuration via web console

### Add VPC endpoint for SQS queue

### Configure private lambda to ouput to SQS Endpoint

### Confirm End-to-End execution


## Additional Sources

- https://boto3.amazonaws.com/v1/documentation/api/latest/guide/sqs.html
- https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-permissions-reference.html
- https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-sending-messages-from-vpc.html
- https://medium.com/tensult/creating-vpc-endpoint-for-amazon-s3-using-terraform-7a15c840d36f
- https://www.javacodemonk.com/python-send-event-from-aws-lambda-to-aws-sqs-a5f299dc
