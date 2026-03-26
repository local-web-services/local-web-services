"""Then: failed messages will be redriven to the dead-letter queue after two receives"""

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaSqsTestClient


@then("failed messages will be redriven to the dead-letter queue after two receives")
def redrive_configured(lws_session):
    import json

    resp = lws_session.client("sqs").get_queue_attributes(
        QueueUrl=LambdaSqsTestClient(lws_session).queue_url(), AttributeNames=["RedrivePolicy"]
    )
    actual_policy = resp["Attributes"].get("RedrivePolicy", "")
    assert actual_policy != "", "Expected a RedrivePolicy to be configured but got none"
    policy = json.loads(actual_policy)
    expected_count = 2
    actual_count = int(policy.get("maxReceiveCount", 0))
    assert (
        actual_count == expected_count
    ), f"Expected maxReceiveCount '{expected_count}' but got '{actual_count}'"
