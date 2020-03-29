import boto3
import json
import logging
import os

from botocore.exceptions import ClientError

def send_sqs_message(QueueName, msg_body):
    """

    :param sqs_queue_url: String URL of existing SQS queue
    :param msg_body: String message body
    :return: Dictionary containing information about the sent message. If
        error, returns None.
    """

    # Send the SQS message
    sqs_client = boto3.client('sqs')
    sqs_queue_url = sqs_client.get_queue_url(
        QueueName=QueueName
    )['QueueUrl']
    try:
        msg = sqs_client.send_message(QueueUrl=sqs_queue_url, MessageBody=json.dumps(msg_body))
    except ClientError as e:
        logging.error(e)
        return None
    return msg


def lambda_handler(event, context):
    """Exercise send_sqs_message()"""

    QueueName = str(os.environ['QueueArn'].split(':')[-1])
    print('QueueName:', QueueName)

    # Set up logging
    logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(asctime)s: %(message)s')

    # Send some SQS messages

    msg = send_sqs_message(QueueName,event)
    if msg is not None:
        logging.info(f'Sent SQS message ID: {msg["MessageId"]}')
    return {
        'statusCode': 200,
        'body': json.dumps(event)
    }
