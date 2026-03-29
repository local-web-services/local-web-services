"""Then: the queue is "DELETED" and its messages are removed"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_QUEUE


@then('the queue is "DELETED" and its messages are removed')
def queue_is_deleted_then(client):
    r = client.post("/", data={"Action": "ListQueues", "QueueNamePrefix": TEST_QUEUE})
    expected_absent = TEST_QUEUE
    actual_text = r.text
    assert (
        expected_absent not in actual_text
    ), f"Expected queue '{expected_absent}' to be deleted but found in: {actual_text}"
