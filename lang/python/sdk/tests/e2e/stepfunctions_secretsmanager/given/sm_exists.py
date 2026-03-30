"""Given: the state machine exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given("the state machine exists")
def sm_exists(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_sm()
