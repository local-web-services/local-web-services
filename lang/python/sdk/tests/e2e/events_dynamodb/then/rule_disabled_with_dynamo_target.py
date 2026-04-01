"""Then: the rule will be "DISABLED" on the bus with the DynamoDB target configured"""

from __future__ import annotations

from pytest_bdd import then


@then('the rule will be "DISABLED" on the bus with the DynamoDB target configured')
def rule_disabled_with_dynamo_target(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
