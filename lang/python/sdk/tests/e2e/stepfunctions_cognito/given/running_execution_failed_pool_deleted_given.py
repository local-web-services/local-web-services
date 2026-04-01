"""Given: a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" fails because the "cognito" "user pool" has been deleted'
)
def running_execution_failed_pool_deleted_given():
    pytest.skip("Cannot pre-set a failed execution Cognito task state for sequence setup")
