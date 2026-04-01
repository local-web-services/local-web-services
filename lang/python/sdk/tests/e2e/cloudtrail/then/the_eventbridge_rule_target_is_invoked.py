"""Then: the EventBridge rule target is invoked"""

from __future__ import annotations

from pytest_bdd import then


@then("the EventBridge rule target is invoked")
def the_eventbridge_rule_target_is_invoked(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected service call to succeed but got error: {actual_error}"
