"""Then: the queue is "ACTIVE" with no dead-letter queue configured"""

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaSqsTestClient


@then('the queue is "ACTIVE" with no dead-letter queue configured')
def queue_is_active_no_dlq(lws_session):
    resp = lws_session.client("sqs").get_queue_attributes(
        QueueUrl=LambdaSqsTestClient(lws_session).queue_url(), AttributeNames=["RedrivePolicy"]
    )
    actual_redrive = resp["Attributes"].get("RedrivePolicy", "")
    expected_redrive = ""
    assert (
        actual_redrive == expected_redrive
    ), f"Expected no RedrivePolicy but got '{actual_redrive}'"
