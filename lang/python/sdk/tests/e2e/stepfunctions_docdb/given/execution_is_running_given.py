"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDocdbTestClient


@given('a "step functions" "execution" was "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsDocdbTestClient(lws_session).create_sm()
    StepfunctionsDocdbTestClient(lws_session).start_execution()
