"""Then: the pool is "DELETED" and Lambda calls targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaCognitoTestClient


@then('the pool is "DELETED" and Lambda calls targeting it will fail')
def pool_is_deleted_then(lws_session):
    pool_id = LambdaCognitoTestClient(lws_session).pool_id()
    assert pool_id is None, f"Expected pool to be deleted but found pool with id '{pool_id}'"
