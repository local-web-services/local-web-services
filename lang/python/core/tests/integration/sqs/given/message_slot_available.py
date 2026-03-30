"""Given: the message slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the message slot is available")
def message_slot_available():
    """No-op: always room for messages in an empty queue."""
