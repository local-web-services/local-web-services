"""Given: a request matching an "aws fake" "operation" is intercepted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('a request matching an "aws fake" "operation" is intercepted')
def aws_fake_request_intercepted(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation()
    AwsFakeTestClient(lws_session).make_aws_call()
