"""Given: a "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given('a "step functions" "state machine" is created')
def events_sfn_seq_sm_created(lws_session, world):
    world["state_machine_arn"] = EventsStepfunctionsTestClient(lws_session).create_sm()
