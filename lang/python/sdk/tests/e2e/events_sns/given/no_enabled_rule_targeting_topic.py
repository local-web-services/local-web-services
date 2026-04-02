"""Given: no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given


@given(
    'no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"'
)
def no_enabled_rule_targeting_topic(world):
    world["result"] = None
    world["error"] = None
