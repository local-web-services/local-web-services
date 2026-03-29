"""Then: the pool is "DELETED" and "SDK" task calls targeting it will fail"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsCognitoTestClient
from ..constants import TEST_POOL


@then('the pool is "DELETED" and "SDK" task calls targeting it will fail')
def pool_is_deleted_then(lws_session):
    pool_id = StepfunctionsCognitoTestClient(lws_session).get_pool_id()
    expected_pool_id = None
    actual_pool_id = pool_id
    assert (
        actual_pool_id is expected_pool_id
    ), f"Expected pool '{TEST_POOL}' to be deleted but it still exists with id: {actual_pool_id}"
