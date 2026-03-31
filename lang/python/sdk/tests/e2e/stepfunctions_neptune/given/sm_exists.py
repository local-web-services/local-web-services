"""Given: the "step functions" "state machine" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsNeptuneTestClient


@given('the "step functions" "state machine" existed')
def sm_exists(lws_session):
    StepfunctionsNeptuneTestClient(lws_session).create_sm()
