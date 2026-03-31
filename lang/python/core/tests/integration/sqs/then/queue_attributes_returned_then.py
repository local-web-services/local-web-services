"""Then: the "sqs" "queue" attributes will be returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import QUEUE_URL


@then('the "sqs" "queue" attributes will be returned')
def queue_attributes_returned_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "All",
        },
    )
    expected_status = 200
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected GetQueueAttributes to return {expected_status} but got: {actual_status}"
