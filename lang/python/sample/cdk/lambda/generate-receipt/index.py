import json
import os
from datetime import datetime, timezone

import boto3

s3 = boto3.client('s3')


def handler(event, context):
    order_id = event.get('orderId', 'unknown')
    key = f'receipts/{order_id}.json'

    receipt = {
        'orderId': order_id,
        'generatedAt': datetime.now(timezone.utc).isoformat(),
        'items': event.get('items', []),
        'total': event.get('total', 0),
        'status': 'RECEIPT_GENERATED',
    }

    s3.put_object(
        Bucket=os.environ['BUCKET_NAME'],
        Key=key,
        Body=json.dumps(receipt, indent=2),
        ContentType='application/json',
    )

    return {'orderId': order_id, 'receiptKey': key}
