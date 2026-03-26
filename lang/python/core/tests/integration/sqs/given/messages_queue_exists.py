"""Given: the message's queue exists"""

from __future__ import annotations

from pytest_bdd import given


@given("the message's queue exists")
def messages_queue_exists():
    """No-op: queue was created in 'the message exists' step."""
