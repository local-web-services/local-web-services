"""Given: the "operation" has a header filter"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "operation" has a header filter')
def aws_fake_operation_has_header_filter(lws_session):
    AwsFakeTestClient(lws_session).add_operation_with_header()
