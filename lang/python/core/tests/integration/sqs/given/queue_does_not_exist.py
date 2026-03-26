"""Given: the queue does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import QUEUE_URL


@given("the queue does not exist")
def queue_does_not_exist(client):
    """Ensure the queue does not exist; it was never created in the fresh provider."""
    client.post("/", data={"Action": "DeleteQueue", "QueueUrl": QUEUE_URL})
