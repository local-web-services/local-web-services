"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient
from ..constants import TEST_INPUT


@given('an execution is "RUNNING"')
def execution_is_running(lws_session, world):
    world["state_machine_arn"] = EventsStepfunctionsTestClient(lws_session).create_sm()
    resp = EventsStepfunctionsTestClient(lws_session)._sfn.start_execution(
        stateMachineArn=world["state_machine_arn"], input=TEST_INPUT
    )
    world["execution_arn"] = resp["executionArn"]
