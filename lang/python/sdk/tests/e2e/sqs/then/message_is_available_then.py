"""Then: the "sqs" "message" will be "AVAILABLE" for delivery"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient
from ..constants import TEST_MESSAGE


@then('the "sqs" "message" will be "AVAILABLE" for delivery')
def message_is_available_then(lws_session):
    msg = SqsTestClient(lws_session).receive_message()
    expected_body = TEST_MESSAGE
    actual_body = msg["Body"] if msg else None
    assert (
        actual_body == expected_body
    ), f"Expected message body '{expected_body}' but got '{actual_body}'"
