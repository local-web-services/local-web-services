"""Given: the bus did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "secretsmanager" "secret" did not already exist')
def secret_not_already_exist():
    """No-op: fresh state has no secrets."""
