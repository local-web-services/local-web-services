"""Given: pid in pool_status"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given("pid in pool_status")
def pid_in_pool_status(lws_session):
    try:
        LambdaCognitoTestClient(lws_session).create_pool()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceInUseException":
            raise
