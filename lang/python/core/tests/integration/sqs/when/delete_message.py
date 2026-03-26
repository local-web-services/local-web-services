"""When: an in-flight message is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when("an in-flight message is deleted")
def delete_message(client, world):
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "DeleteMessage",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
