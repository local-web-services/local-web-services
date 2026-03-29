"""Given: cfid in caller_status"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given("cfid in caller_status")
def cfid_in_caller_status(lws_session):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
