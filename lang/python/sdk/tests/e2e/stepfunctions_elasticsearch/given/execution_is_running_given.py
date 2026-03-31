"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given('a "step functions" "execution" was "RUNNING"')
def execution_is_running_given(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_sm()
    StepfunctionsElasticsearchTestClient(lws_session).start_execution()
