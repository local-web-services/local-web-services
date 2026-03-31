"""When: a "sqs" "queue" is created"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_QUEUE


@when('a "sqs" "queue" is created')
def create_queue(client, world):
    r = client.post("/", data={"Action": "CreateQueue", "QueueName": TEST_QUEUE})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
