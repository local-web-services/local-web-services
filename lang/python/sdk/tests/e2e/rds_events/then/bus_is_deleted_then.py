"""Then: the "eventbridge" "bus" will be deleted and "RDS" event delivery will fail"""

from __future__ import annotations

from pytest_bdd import then


@then('the "eventbridge" "bus" will be deleted and "RDS" event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"
