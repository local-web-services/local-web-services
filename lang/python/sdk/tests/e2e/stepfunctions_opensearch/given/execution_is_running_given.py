"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_sm()
    StepfunctionsOpensearchTestClient(lws_session).start_execution()
