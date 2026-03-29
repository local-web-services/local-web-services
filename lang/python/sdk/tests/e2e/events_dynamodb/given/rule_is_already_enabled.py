"""Given: the rule is already "ENABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('the rule is already "ENABLED"')
def rule_is_already_enabled():
    """No-op: rules are ENABLED by default after creation by 'the rule exists' step."""
