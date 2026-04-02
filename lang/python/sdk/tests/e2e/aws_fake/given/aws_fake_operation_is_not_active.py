"""Given: the "aws fake" "operation" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('the "aws fake" "operation" was not "ACTIVE"')
def aws_fake_operation_is_not_active(lws_session):
    AwsFakeTestClient(lws_session).remove_operation()
