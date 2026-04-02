"""Then: the "eventbridge" "rule" will be "ENABLED" and will forward matching events to the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "eventbridge" "rule" will be "ENABLED" and will forward matching events to the "sqs" "queue"'
)
def rule_enabled_targeting_queue(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
