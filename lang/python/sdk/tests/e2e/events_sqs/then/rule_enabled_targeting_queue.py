"""Then: the rule will be "ENABLED" and will forward matching events to the queue"""

from __future__ import annotations

from pytest_bdd import then


@then('the rule will be "ENABLED" and will forward matching events to the queue')
def rule_enabled_targeting_queue(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
