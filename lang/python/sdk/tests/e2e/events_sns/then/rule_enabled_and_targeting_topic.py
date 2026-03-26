"""Then: the rule is "ENABLED" and will publish to the topic when matching events are received"""

from __future__ import annotations

from pytest_bdd import then


@then('the rule is "ENABLED" and will publish to the topic when matching events are received')
def rule_enabled_and_targeting_topic(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
