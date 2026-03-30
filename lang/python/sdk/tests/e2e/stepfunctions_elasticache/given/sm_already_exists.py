"""Given: the state machine already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsElasticacheTestClient


@given("the state machine already exists")
def sm_already_exists(lws_session):
    StepfunctionsElasticacheTestClient(lws_session).create_sm()
