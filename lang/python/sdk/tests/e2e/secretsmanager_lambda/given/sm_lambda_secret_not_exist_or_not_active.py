"""Given: the secrets manager secret did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the secrets manager secret did not exist or was "ACTIVE"')
def sm_lambda_secret_not_exist_or_not_active():
    """No-op: fresh state has no secrets."""
