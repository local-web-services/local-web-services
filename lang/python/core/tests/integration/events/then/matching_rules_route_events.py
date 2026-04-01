"""Then: matching enabled rules route the event to their targets."""

from __future__ import annotations

from pytest_bdd import then


@then("matching enabled rules route the event to their targets")
def matching_rules_route_events(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
    actual_failed = world["result"].get("FailedEntryCount", -1)
    assert actual_failed == 0, f"Expected FailedEntryCount == 0 but got: {actual_failed}"
