"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    LambdaSsmTestClient(lws_session).create_function()
