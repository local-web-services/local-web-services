"""When: a running execution fails because the Cognito user pool has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a running execution fails because the Cognito user pool has been deleted")
def execution_fails_pool_deleted(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to deleted Cognito pool in lws"
    )
