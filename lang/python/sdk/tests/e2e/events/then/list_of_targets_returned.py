"""Then: the list of "eventbridge" "rule" targets will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the list of "eventbridge" "rule" targets will be returned')
def list_of_targets_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_targets_by_rule to succeed but got: {world['error']}"
    assert "Targets" in world["result"], "Expected 'Targets' in response"
