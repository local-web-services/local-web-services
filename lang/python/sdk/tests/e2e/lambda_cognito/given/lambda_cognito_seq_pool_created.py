"""Given: a "cognito" "user pool" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given('a "cognito" "user pool" is created')
def lambda_cognito_seq_pool_created(lws_session):
    try:
        LambdaCognitoTestClient(lws_session).create_pool()
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceInUseException":
            raise
