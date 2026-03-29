"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given("fid in func_status")
def sm_lambda_fid_in_func_status(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_function()
