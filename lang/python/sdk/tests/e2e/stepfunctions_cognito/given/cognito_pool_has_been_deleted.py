"""Given: a "cognito" "user pool" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "cognito" "user pool" is deleted')
def cognito_pool_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted Cognito user pool state for sequence setup")
