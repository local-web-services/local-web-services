"""Given: fid in func_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("fid in func_status")
def lambda_s3tables_fid_in_func_status(lws_session):
    LambdaS3tablesTestClient(lws_session).create_function()
