"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session, world):
    client = StepfunctionsSsmTestClient(lws_session)
    client.create_sm()
    execution_arn = client.start_execution()
    world["execution_arn"] = execution_arn
