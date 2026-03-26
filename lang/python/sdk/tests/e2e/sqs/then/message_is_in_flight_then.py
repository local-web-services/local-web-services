"""Then: the message is "IN_FLIGHT" """

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient


@then('the message is "IN_FLIGHT"')
def message_is_in_flight_then(lws_session):
    client = SqsTestClient(lws_session).sqs()
    resp = client.get_queue_attributes(
        QueueUrl=SqsTestClient(lws_session).queue_url(),
        AttributeNames=["ApproximateNumberOfMessagesNotVisible"],
    )
    expected_count = "1"
    actual_count = resp["Attributes"].get("ApproximateNumberOfMessagesNotVisible", "0")
    assert actual_count == expected_count, f"Expected 1 in-flight message but got {actual_count}"
