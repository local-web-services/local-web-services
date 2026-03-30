"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_sm()
    StepfunctionsS3tablesTestClient(lws_session).start_execution()
