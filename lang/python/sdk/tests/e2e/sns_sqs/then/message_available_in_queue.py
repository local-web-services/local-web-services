"""Then: the message will be "AVAILABLE" in the queue"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE, TEST_QUEUE


@then('the message will be "AVAILABLE" in the queue')
def message_available_in_queue(lws_session):
    url = SnsSqsTestClient(lws_session).queue_url()
    expected_message = TEST_MESSAGE
    resp = lws_session.client("sqs").receive_message(
        QueueUrl=url, MaxNumberOfMessages=1, WaitTimeSeconds=1
    )
    actual_messages = resp.get("Messages", [])
    assert (
        len(actual_messages) > 0
    ), f"Expected at least one message containing '{expected_message}' in queue '{TEST_QUEUE}' but queue was empty"  # noqa: E501
    actual_body = actual_messages[0].get("Body", "")
    assert (
        expected_message in actual_body
    ), f"Expected message body to contain '{expected_message}' but got: {actual_body}"
