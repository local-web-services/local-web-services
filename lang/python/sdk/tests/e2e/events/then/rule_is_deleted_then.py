"""Then: the "eventbridge" "rule" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "eventbridge" "rule" will be "DELETED"')
def rule_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_rule to succeed but got: {world['error']}"
