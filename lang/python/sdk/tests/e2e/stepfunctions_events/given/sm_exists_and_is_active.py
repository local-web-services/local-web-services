"""Given: the state machine exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('the state machine exists and is "ACTIVE"')
def sm_exists_and_is_active(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_sm()
