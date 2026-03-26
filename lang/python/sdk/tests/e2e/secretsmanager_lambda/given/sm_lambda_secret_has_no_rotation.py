"""Given: the secret has no rotation function configured"""

from __future__ import annotations

from pytest_bdd import given


@given("the secret has no rotation function configured")
def sm_lambda_secret_has_no_rotation():
    """No-op: secrets have no rotation function configured by default."""
