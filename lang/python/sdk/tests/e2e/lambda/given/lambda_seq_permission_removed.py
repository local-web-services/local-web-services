"""Given: a permission has been removed from a function's resource policy"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("a permission has been removed from a function's resource policy")
def lambda_seq_permission_removed(lws_session):
    LambdaTestClient(lws_session).create_function()
