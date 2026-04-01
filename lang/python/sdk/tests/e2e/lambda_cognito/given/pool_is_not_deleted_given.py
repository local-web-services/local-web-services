"""Given: the "cognito" "user pool" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaCognitoTestClient


@given('the "cognito" "user pool" was not "DELETED"')
def pool_is_not_deleted_given(lws_session):
    LambdaCognitoTestClient(lws_session).create_pool()
