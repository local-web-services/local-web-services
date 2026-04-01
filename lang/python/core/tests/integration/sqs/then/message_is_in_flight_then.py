"""Then: the "sqs" "message" will be "IN_FLIGHT" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import QUEUE_URL


@then('the "sqs" "message" will be "IN_FLIGHT"')
def message_is_in_flight_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "ApproximateNumberOfMessagesNotVisible",
        },
    )
    expected_count = "1"
    actual_text = r.text
    assert (
        expected_count in actual_text
    ), f"Expected 1 in-flight message but response was: {actual_text}"
