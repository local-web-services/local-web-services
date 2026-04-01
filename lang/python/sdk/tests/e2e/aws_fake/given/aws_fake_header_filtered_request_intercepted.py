"""Given: a request matching a header-filtered operation is intercepted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given("a request matching a header-filtered operation is intercepted")
def aws_fake_header_filtered_request_intercepted(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation_with_header()
    AwsFakeTestClient(lws_session).make_aws_call()
