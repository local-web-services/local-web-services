"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticacheTestClient


@given("fid in func_status")
def fid_in_func_status(lws_session):
    LambdaElasticacheTestClient(lws_session).create_function()
