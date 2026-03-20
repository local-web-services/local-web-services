import json
import os

import boto3

ddb = boto3.client('dynamodb')


def handler(event, context):
    order_id = (event.get('pathParameters') or {}).get('id')

    if not order_id:
        return {
            'statusCode': 400,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'error': 'Missing orderId'}),
        }

    result = ddb.get_item(
        TableName=os.environ['TABLE_NAME'],
        Key={'orderId': {'S': order_id}},
    )

    item = result.get('Item')
    if not item:
        return {
            'statusCode': 404,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'error': 'Order not found'}),
        }

    order = {
        'orderId': item['orderId']['S'],
        'customerName': item['customerName']['S'],
        'items': json.loads(item['items']['S']),
        'total': float(item['total']['N']),
        'status': item['status']['S'],
        'createdAt': item['createdAt']['S'],
    }

    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps(order),
    }
