"""When: a message visibility timeout expires"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when("a message visibility timeout expires")
def visibility_timeout_expires(client, world):
    """Simulate by setting visibility timeout to 0 (makes message AVAILABLE again)."""
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "ChangeMessageVisibility",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
            "VisibilityTimeout": "0",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
