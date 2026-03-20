import json
import os
import uuid
from datetime import datetime, timezone

import boto3

ddb = boto3.client('dynamodb')
sqs = boto3.client('sqs')


def handler(event, context):
    body = json.loads(event.get('body') or '{}')
    order_id = str(uuid.uuid4())
    now = datetime.now(timezone.utc).isoformat()

    ddb.put_item(
        TableName=os.environ['TABLE_NAME'],
        Item={
            'orderId': {'S': order_id},
            'customerName': {'S': body.get('customerName', 'Unknown')},
            'items': {'S': json.dumps(body.get('items', []))},
            'total': {'N': str(body.get('total', 0))},
            'status': {'S': 'CREATED'},
            'createdAt': {'S': now},
        },
    )

    sqs.send_message(
        QueueUrl=os.environ['QUEUE_URL'],
        MessageBody=json.dumps({'orderId': order_id, **body}),
    )

    return {
        'statusCode': 201,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps({'orderId': order_id, 'status': 'CREATED', 'createdAt': now}),
    }
