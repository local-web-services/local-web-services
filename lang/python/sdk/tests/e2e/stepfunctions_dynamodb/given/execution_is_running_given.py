"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsDynamodbTestClient(lws_session).create_sm()
    StepfunctionsDynamodbTestClient(lws_session).start_execution()
