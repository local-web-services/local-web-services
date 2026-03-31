"""Then: the "sqs" "queue" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_QUEUE


@then('the "sqs" "queue" will be "ACTIVE"')
def queue_is_active_then(client):
    r = client.post("/", data={"Action": "ListQueues", "QueueNamePrefix": TEST_QUEUE})
    expected_fragment = TEST_QUEUE
    actual_text = r.text
    assert (
        expected_fragment in actual_text
    ), f"Expected queue '{expected_fragment}' to be ACTIVE but not found in: {actual_text}"
