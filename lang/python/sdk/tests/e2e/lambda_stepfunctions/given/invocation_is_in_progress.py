"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_function()
