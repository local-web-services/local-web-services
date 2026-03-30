"""Then: all messages in the queue are "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import QUEUE_URL


@then('all messages in the queue are "DELETED"')
def all_messages_deleted_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "ApproximateNumberOfMessages",
        },
    )
    expected_count = "0"
    actual_text = r.text
    assert (
        expected_count in actual_text
    ), f"Expected 0 messages after purge but response was: {actual_text}"
