"""Given: the state machine exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given("the state machine exists")
def sm_exists(lws_session):
    StepfunctionsSqsTestClient(lws_session).create_sm()
