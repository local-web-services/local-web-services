"""Then: the "sqs" "message" will be "AVAILABLE" in the dead-letter "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient
from ..constants import TEST_DLQ


@then('the "sqs" "message" will be "AVAILABLE" in the dead-letter "sqs" "queue"')
def message_in_dlq_then(lws_session):
    msg = SqsTestClient(lws_session).receive_message(TEST_DLQ)
    assert msg is not None, "Expected message in dead-letter queue but found none"
