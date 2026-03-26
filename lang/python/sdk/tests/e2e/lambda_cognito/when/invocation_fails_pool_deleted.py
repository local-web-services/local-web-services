"""When: the Lambda function fails to call Cognito because the pool has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to call Cognito because the pool has been deleted")
def invocation_fails_pool_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
