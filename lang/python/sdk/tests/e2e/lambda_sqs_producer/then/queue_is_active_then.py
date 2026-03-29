"""Then: the queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaSqsProducerTestClient


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    resp = lws_session.client("sqs").get_queue_attributes(
        QueueUrl=LambdaSqsProducerTestClient(lws_session).queue_url(), AttributeNames=["QueueArn"]
    )
    actual_arn = resp["Attributes"].get("QueueArn", "")
    expected_prefix = "arn:aws:sqs:"
    assert actual_arn.startswith(
        expected_prefix
    ), f"Expected queue ARN starting with '{expected_prefix}' but got '{actual_arn}'"
