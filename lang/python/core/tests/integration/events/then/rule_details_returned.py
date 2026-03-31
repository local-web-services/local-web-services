"""Then: the rule details are returned."""

from __future__ import annotations

from pytest_bdd import then


@then('the "eventbridge" "rule" details will be returned')
def rule_details_returned(world):
    assert world["error"] is None, f"Expected describe_rule to succeed but got: {world['error']}"
    assert "Name" in world["result"], "Expected 'Name' key in response"
