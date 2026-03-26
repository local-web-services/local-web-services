"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    LambdaSqsProducerTestClient(lws_session).create_function()
