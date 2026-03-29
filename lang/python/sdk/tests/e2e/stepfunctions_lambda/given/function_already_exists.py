"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given("the function already exists")
def function_already_exists(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_function()
