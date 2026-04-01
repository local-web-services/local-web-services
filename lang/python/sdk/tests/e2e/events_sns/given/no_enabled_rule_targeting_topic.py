"""Given: no "ENABLED" rule existed on the bus targeting a topic"""

from __future__ import annotations

from pytest_bdd import given


@given('no "ENABLED" rule existed on the bus targeting a topic')
def no_enabled_rule_targeting_topic(world):
    world["result"] = None
    world["error"] = None
