"""Given: fid in func_status"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given("fid in func_status")
def fid_in_func_status(lws_session):
    try:
        LambdaNeptuneTestClient(lws_session).create_function()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
