"""Given: rid not in rule_status"""

from __future__ import annotations

from pytest_bdd import given


@given("rid not in rule_status")
def events_sfn_rid_not_in_rule_status():
    """No-op: fresh state has no rules."""
