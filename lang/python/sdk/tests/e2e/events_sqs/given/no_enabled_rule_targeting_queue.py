"""Given: no "ENABLED" rule exists on the bus targeting a queue"""

from __future__ import annotations

from pytest_bdd import given


@given('no "ENABLED" rule exists on the bus targeting a queue')
def no_enabled_rule_targeting_queue(world):
    world["result"] = None
    world["error"] = None
