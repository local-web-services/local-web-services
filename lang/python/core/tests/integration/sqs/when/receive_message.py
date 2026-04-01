"""When: a "sqs" "message" is received from the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL, _extract_xml_tag


@when('a "sqs" "message" is received from the "sqs" "queue"')
def receive_message(client, world):
    r = client.post(
        "/",
        data={
            "Action": "ReceiveMessage",
            "QueueUrl": QUEUE_URL,
            "MaxNumberOfMessages": "1",
            "VisibilityTimeout": "30",
            "WaitTimeSeconds": "0",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
        if "<ReceiptHandle>" in r.text:
            world["receipt_handle"] = _extract_xml_tag(r.text, "ReceiptHandle")
    else:
        world["result"] = None
        world["error"] = r.text
