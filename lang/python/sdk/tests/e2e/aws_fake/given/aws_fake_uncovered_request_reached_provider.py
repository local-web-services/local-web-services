"""Given: a request for an operation not covered by the "AWS" fake reaches the provider"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('a request for an operation not covered by the "AWS" fake reaches the provider')
def aws_fake_uncovered_request_reached_provider(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).make_aws_call()
