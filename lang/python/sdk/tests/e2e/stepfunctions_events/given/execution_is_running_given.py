"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given('a "step functions" "execution" was "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_sm()
    StepfunctionsEventsTestClient(lws_session).start_execution()
