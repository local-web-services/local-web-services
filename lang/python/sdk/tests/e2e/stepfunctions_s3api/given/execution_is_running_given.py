"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient


@given('a "step functions" "execution" was "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsS3apiTestClient(lws_session).create_sm()
    StepfunctionsS3apiTestClient(lws_session).start_execution()
