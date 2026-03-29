"""Given: the pool is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given('the pool is not "DELETED"')
def pool_is_not_deleted_given(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
