"""Given: an "operation" is removed from an "aws fake" """

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('an "operation" is removed from an "aws fake"')
def aws_fake_operation_has_been_removed(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation()
    AwsFakeTestClient(lws_session).remove_operation()
