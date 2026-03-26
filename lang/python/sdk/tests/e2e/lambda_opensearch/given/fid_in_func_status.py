"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given("fid in func_status")
def fid_in_func_status(lws_session):
    LambdaOpensearchTestClient(lws_session).create_function()
