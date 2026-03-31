"""Then: the rule will be "ENABLED" and will trigger an execution when matching events are published"""

from __future__ import annotations

from pytest_bdd import then


@then('the rule will be "ENABLED" and will trigger an execution when matching events are published')
def rule_enabled_targeting_sfn(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"
