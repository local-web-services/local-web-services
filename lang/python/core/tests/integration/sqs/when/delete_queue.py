"""When: a queue is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when("a queue is deleted")
def delete_queue(client, world):
    r = client.post("/", data={"Action": "DeleteQueue", "QueueUrl": QUEUE_URL})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
