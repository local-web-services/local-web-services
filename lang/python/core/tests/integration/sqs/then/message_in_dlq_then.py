"""Then: the message is "AVAILABLE" in the dead-letter queue"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient
from ..constants import DLQ_URL


@then('the message is "AVAILABLE" in the dead-letter queue')
def message_in_dlq_then(client):
    msg = SqsTestClient(client).receive_message(DLQ_URL)
    assert msg is not None, "Expected message in dead-letter queue but found none"
