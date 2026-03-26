"""Given: a Cognito user pool has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("a Cognito user pool has been deleted")
def lambda_cognito_seq_pool_deleted():
    """No-op: fresh state has no pools, simulates a previously deleted pool."""
