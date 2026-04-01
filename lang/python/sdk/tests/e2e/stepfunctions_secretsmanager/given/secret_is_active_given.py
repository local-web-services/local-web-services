"""Given: the "secrets manager" "secret" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "secrets manager" "secret" was "ACTIVE"')
def secret_is_active_given():
    """No-op: secrets are ACTIVE immediately after creation."""
