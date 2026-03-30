"""Given: a Cognito user pool has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a Cognito user pool has been deleted")
def cognito_pool_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted Cognito user pool state for sequence setup")
