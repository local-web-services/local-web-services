"""Given: a Step Functions state machine has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("a Step Functions state machine has been created")
def sfn_sm_has_been_created(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_sm()
