"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_sm()
    StepfunctionsSecretsmanagerTestClient(lws_session).start_execution()
