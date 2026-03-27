"""Given: the operation exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given("the operation exists")
def aws_fake_operation_exists(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation()
