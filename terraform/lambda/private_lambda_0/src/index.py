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

def send_sqs_message(QueueName, msg_body):
    """

    :param sqs_queue_url: String URL of existing SQS queue
    :param msg_body: String message body
    :return: Dictionary containing information about the sent message. If
        error, returns None.
    """

    # Send the SQS message
    client = boto3.client('sqs')
    # sqs_queue_url = client.get_queue_url(
    #     QueueName=QueueName
    # )['QueueUrl']
    sqs_queue_url = client.get_queue_url(
        QueueName="aws_terraform_vpc_endpoint-dev-sqs-0qxn	"
    )['QueueUrl']
    # sqs_queue_url = "https://sqs.us-west-2.amazonaws.com/345292015349/aws_terraform_vpc_endpoint-dev-sqs-0qxn"
    print('sqs_queue_url:', sqs_queue_url)

    # try:
    msg = client.send_message(QueueUrl=sqs_queue_url, MessageBody=json.dumps(msg_body))
    print('msg:', msg)
    # except ClientError as e:
    #     logging.error(e)
    #     return None
    return msg


def lambda_handler(event, context):
    """Exercise send_sqs_message()"""

    QueueName = str(os.environ['QueueArn'].split(':')[-1])
    print('QueueName:', QueueName)

    # Setup logging
    logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(asctime)s: %(message)s')

    # Send some SQS messages
    msg = send_sqs_message(QueueName, event)
    
    if msg is not None:
        logging.info(f'Sent SQS message ID: {msg["MessageId"]}')

    return {
        'statusCode': 200,
        'body': json.dumps(event)
    }
