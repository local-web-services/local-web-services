"""Given: an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given(
    'an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "step functions" "state machine"'
)
def enabled_rule_exists_targeting_sfn(lws_session, world):
    world["state_machine_arn"] = EventsStepfunctionsTestClient(lws_session).create_sm()
    EventsStepfunctionsTestClient(lws_session).create_rule_targeting_sfn()
