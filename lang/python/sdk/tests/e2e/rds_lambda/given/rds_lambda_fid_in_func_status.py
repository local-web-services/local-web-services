"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given("fid in func_status")
def rds_lambda_fid_in_func_status(lws_session):
    RdsLambdaTestClient(lws_session).create_function()
