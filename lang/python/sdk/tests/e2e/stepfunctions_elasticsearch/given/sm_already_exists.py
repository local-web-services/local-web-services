"""Given: the state machine already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticsearchTestClient


@given("the state machine already exists")
def sm_already_exists(lws_session):
    StepfunctionsElasticsearchTestClient(lws_session).create_sm()
