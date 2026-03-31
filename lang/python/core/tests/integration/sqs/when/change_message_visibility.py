"""When: "sqs" "message" visibility timeout is changed"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when('"sqs" "message" visibility timeout is changed')
def change_message_visibility(client, world):
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "ChangeMessageVisibility",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
            "VisibilityTimeout": "60",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
