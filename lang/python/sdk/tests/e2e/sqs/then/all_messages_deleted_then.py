"""Then: all messages in the "sqs" "queue" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient


@then('all messages in the "sqs" "queue" will be "DELETED"')
def all_messages_deleted_then(lws_session):
    client = SqsTestClient(lws_session)
    resp = client.get_queue_attributes(
        QueueUrl=SqsTestClient(lws_session).queue_url(),
        AttributeNames=["ApproximateNumberOfMessages"],
    )
    expected_count = "0"
    actual_count = resp["Attributes"].get("ApproximateNumberOfMessages", "0")
    assert actual_count == expected_count, f"Expected 0 messages after purge but got {actual_count}"
