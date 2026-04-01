"""Given: the "cognito" "user pool" was "ACTIVE" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given('the "cognito" "user pool" was "ACTIVE"')
def pool_is_active_given(lws_session):
    try:
        LambdaCognitoTestClient(lws_session).create_pool()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceInUseException":
            raise
