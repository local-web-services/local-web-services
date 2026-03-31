"""Then: the list of rules will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of rules will be returned")
def list_of_rules_returned(world):
    assert world["error"] is None, f"Expected list_rules to succeed but got: {world['error']}"
    assert "Rules" in world["result"], "Expected 'Rules' in response"
