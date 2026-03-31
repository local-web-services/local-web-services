"""Given: no "ENABLED" rule existed on the bus targeting a state machine"""

from __future__ import annotations

from pytest_bdd import given


@given('no "ENABLED" rule existed on the bus targeting a state machine')
def no_enabled_rule_targeting_sfn(world):
    world["result"] = None
    world["error"] = None
