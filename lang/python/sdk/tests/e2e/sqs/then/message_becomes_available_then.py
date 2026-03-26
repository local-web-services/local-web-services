"""Then: the message becomes "AVAILABLE" again"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SqsTestClient


@then('the message becomes "AVAILABLE" again')
def message_becomes_available_then(lws_session):
    msg = SqsTestClient(lws_session).receive_message()
    assert msg is not None, "Expected message to become AVAILABLE again but found none"
