"""Given: no "AVAILABLE" message exists in the queue"""

from __future__ import annotations

from pytest_bdd import given


@given('no "AVAILABLE" message exists in the queue')
def no_available_message_exists():
    """No-op: fresh state has no messages."""
