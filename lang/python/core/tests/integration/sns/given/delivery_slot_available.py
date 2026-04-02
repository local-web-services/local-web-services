"""Given: an "sns" "delivery" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('an "sns" "delivery" "slot" was "available"')
def delivery_slot_available():
    """No-op: always room for deliveries."""
