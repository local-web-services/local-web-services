"""Then: the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue" and the "step functions" "execution" will be "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_MESSAGE_BODY, TEST_QUEUE


@then(
    'the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue" and the "step functions" "execution" will be "SUCCEEDED"'
)
def message_available_and_execution_succeeded(lws_session, world):
    expected_error = None
    expected_message = TEST_MESSAGE_BODY
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    url = StepfunctionsSqsTestClient(lws_session).queue_url()
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
