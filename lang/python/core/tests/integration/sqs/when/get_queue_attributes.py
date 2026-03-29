"""When: queue attributes are retrieved"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import QUEUE_URL


@when("queue attributes are retrieved")
def get_queue_attributes(client, world):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "All",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
