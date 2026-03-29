"""Given: the secret does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the secret does not exist")
def secret_does_not_exist():
    """No-op: fresh state has no secrets."""
