"""When: a "sqs" "message" is sent to the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL, TEST_MESSAGE


@when('a "sqs" "message" is sent to the "sqs" "queue"')
def send_message(client, world):
    r = client.post(
        "/",
        data={
            "Action": "SendMessage",
            "QueueUrl": QUEUE_URL,
            "MessageBody": TEST_MESSAGE,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
