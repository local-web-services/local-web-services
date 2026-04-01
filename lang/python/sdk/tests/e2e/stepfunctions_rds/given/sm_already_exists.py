"""Given: the "step functions" "state machine" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsRdsTestClient


@given('the "step functions" "state machine" already existed')
def sm_already_exists(lws_session):
    StepfunctionsRdsTestClient(lws_session).create_sm()
