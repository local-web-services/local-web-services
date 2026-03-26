"""When: a running execution calls an "ACTIVE" Cognito user pool and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution calls an "ACTIVE" Cognito user pool and the task succeeds')
def execution_calls_active_pool(world):
    pytest.skip("Cannot trigger internal execution step that calls Cognito in lws")
