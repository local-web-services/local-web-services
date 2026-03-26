"""Given: the state machine exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given("the state machine exists")
def sm_exists(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_sm()
