"""Given: the "sqs" "message" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "message" was "AVAILABLE"')
def message_is_available_given(lws_session):
    """No-op: after send_message the message is AVAILABLE by default."""
