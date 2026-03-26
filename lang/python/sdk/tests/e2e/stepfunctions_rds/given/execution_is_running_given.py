"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsRdsTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsRdsTestClient(lws_session).create_sm()
    StepfunctionsRdsTestClient(lws_session).start_execution()
