"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given('the "lambda" "function" already existed')
def function_already_exists(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_function()
