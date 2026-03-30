"""Given: an execution of the state machine has been started"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started(lws_session, world):
    client = StepfunctionsSsmTestClient(lws_session)
    try:
        client.create_sm()
    except Exception:
        pass
    execution_arn = client.start_execution()
    world["execution_arn"] = execution_arn
