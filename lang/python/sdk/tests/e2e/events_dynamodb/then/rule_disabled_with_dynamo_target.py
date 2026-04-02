"""Then: the "eventbridge" "rule" will be "DISABLED" on the "eventbridge" "bus" with the "dynamodb" "table" target configured"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "eventbridge" "rule" will be "DISABLED" on the "eventbridge" "bus" with the "dynamodb" "table" target configured'
)
def rule_disabled_with_dynamo_target(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
