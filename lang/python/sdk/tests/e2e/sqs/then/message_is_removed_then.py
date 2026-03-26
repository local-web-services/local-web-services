"""Then: the message is removed from the queue"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient


@then("the message is removed from the queue")
def message_is_removed_then(lws_session):
    msg = SqsTestClient(lws_session).receive_message()
    assert msg is None, f"Expected no messages but found: {msg}"
