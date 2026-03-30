"""Given: the subscription slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("the subscription slot is available")
def subscription_slot_available():
    """No-op: always room for subscriptions."""
