"""Given: an operation is added to an "AWS" fake"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('an operation is added to an "AWS" fake')
def aws_fake_operation_has_been_added(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation()
