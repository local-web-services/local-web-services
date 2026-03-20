import json
import os

import boto3

ddb = boto3.client('dynamodb')
sns = boto3.client('sns')
ssm = boto3.client('ssm')
sm = boto3.client('secretsmanager')


def handler(event, context):
    records = event.get('Records') or [{'body': json.dumps(event)}]

    max_items_resp = ssm.get_parameter(
        Name=os.environ.get('MAX_ITEMS_PARAM', '/orders/config/max-items')
    )
    max_items = int(max_items_resp['Parameter']['Value'])

    secret_resp = sm.get_secret_value(
        SecretId=os.environ.get('NOTIFICATION_SECRET_ARN', 'orders/notification-api-key')
    )
    notification_key = json.loads(secret_resp['SecretString']).get('apiKey', 'default')

    results = []

    for record in records:
        order = json.loads(record.get('body') or '{}')
        order_id = order.get('orderId')
        if not order_id:
            continue

        ddb.update_item(
            TableName=os.environ['TABLE_NAME'],
            Key={'orderId': {'S': order_id}},
            UpdateExpression='SET #status = :status',
            ExpressionAttributeNames={'#status': 'status'},
            ExpressionAttributeValues={':status': {'S': 'PROCESSED'}},
        )

        from datetime import datetime, timezone
        sns.publish(
            TopicArn=os.environ['TOPIC_ARN'],
            Subject=f'Order {order_id} processed',
            Message=json.dumps({
                'orderId': order_id,
                'status': 'PROCESSED',
                'timestamp': datetime.now(timezone.utc).isoformat(),
                'maxItems': max_items,
                'notificationKey': notification_key[:4] + '****',
            }),
        )

        results.append({'orderId': order_id, 'status': 'PROCESSED'})

    return {'processed': len(results), 'results': results}
