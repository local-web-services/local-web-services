"""Given: oid in op_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given("oid in op_status")
def aws_fake_oid_in_op_status(lws_session):
    AwsFakeTestClient(lws_session).create()
    AwsFakeTestClient(lws_session).add_operation()
