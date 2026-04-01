"""Given: the "step functions" "state machine" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('the "step functions" "state machine" existed')
def sm_exists(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_sm()
