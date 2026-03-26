"""When: all messages in a queue are purged"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when("all messages in a queue are purged")
def purge_queue(client, world):
    r = client.post("/", data={"Action": "PurgeQueue", "QueueUrl": QUEUE_URL})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
