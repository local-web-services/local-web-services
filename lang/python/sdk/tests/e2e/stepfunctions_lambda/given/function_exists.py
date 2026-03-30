"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given("the function exists")
def function_exists(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_function()
