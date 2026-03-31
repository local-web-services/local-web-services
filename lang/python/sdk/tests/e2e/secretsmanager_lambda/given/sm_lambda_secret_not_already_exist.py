"""Given: the "secretsmanager" "secret" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "secretsmanager" "secret" did not already exist')
def sm_lambda_secret_not_already_exist():
    """No-op: fresh state has no secrets."""
