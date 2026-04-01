"""Given: the "step functions" "state machine" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('the "step functions" "state machine" existed')
def sm_exists(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_sm()
