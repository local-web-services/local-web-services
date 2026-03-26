"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    LambdaRdsTestClient(lws_session).create_function()
