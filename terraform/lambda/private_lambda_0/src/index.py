import boto3
import json
import logging
import os

from botocore.exceptions import ClientError

# ADDED logging configuration to make debugging easier
root = logging.getLogger()
if root.handlers:
    for handler in root.handlers:
        root.removeHandler(handler)

def send_sqs_message(QueueName, AwsAcctId, Region, event):
    """
    :param sqs_queue_url: String URL of existing SQS queue
    :param msg_body: String message body
    :return: Dictionary containing information about the sent message. If
        error, returns None.
    """

    # Send the SQS message
    # source https://github.com/boto/boto3/issues/2339
    client = boto3.client('sqs', endpoint_url='https://sqs.' + Region + '.amazonaws.com')
    print('client:', client)

    # boto3 has an issue not finding the queue using the built in clientget_queue_url()
    # print('QueueName:', QueueName)
    # sqs_queue_url = client.get_queue_url(
    #     QueueName=QueueName,
    #     QueueOwnerAWSAccountId=AwsAcctId
    # )['QueueUrl']
    sqs_queue_url = 'https://sqs.' + Region + '.amazonaws.com/' + AwsAcctId+ '/' + QueueName
    print('sqs_queue_url:', sqs_queue_url)

    try:
        msg = client.send_message(
            QueueUrl=str(sqs_queue_url),
            MessageBody=str(event)
        )
        print('msg:', msg)
    except ClientError as e:
        logging.error(e)
        return None
    return msg

def lambda_handler(event, context):
    """
    :param event: String URL of existing SQS queue
    :param context: String message body
    :return: Dictionary containing information about the function execution.
    """

    # import globals
    AwsAcctId = str(os.environ['AWS_ACCT_ID'])
    QueueName = str(os.environ['QUEUE_ARN'].split(':')[-1])
    Region = str(os.environ['REGION'])
    print('QueueName:', QueueName)
    print('Region:', Region)

    # Setup logging
    logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(asctime)s: %(message)s')

    # Send some SQS messages
    msg = send_sqs_message(QueueName, AwsAcctId, Region, event)
    
    # error handling
    if msg is not None:
        logging.info(f'Sent SQS message ID: {msg["MessageId"]}')

    return {
        'statusCode': 200,
        'body': json.dumps(event)
    }
