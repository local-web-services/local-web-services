"""Given: the "step functions" "state machine" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('the "step functions" "state machine" already existed')
def sm_already_exists(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_sm()
