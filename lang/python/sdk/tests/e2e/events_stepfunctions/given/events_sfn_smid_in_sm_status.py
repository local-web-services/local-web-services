"""Given: smid in sm_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient


@given("smid in sm_status")
def events_sfn_smid_in_sm_status(lws_session, world):
    world["state_machine_arn"] = EventsStepfunctionsTestClient(lws_session).create_sm()
