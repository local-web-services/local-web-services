"""Given: an execution is "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsSqsTestClient(lws_session).create_sm()
    StepfunctionsSqsTestClient(lws_session).start_execution()
