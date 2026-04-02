"""Given: a "sqs" "message" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "sqs" "message" "slot" was "available"')
def message_slot_available():
    """No-op: always room for messages."""
