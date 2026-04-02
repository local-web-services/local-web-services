"""Given: no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import given


@given(
    'no "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"'
)
def no_enabled_rule_targeting_queue(world):
    world["result"] = None
    world["error"] = None
