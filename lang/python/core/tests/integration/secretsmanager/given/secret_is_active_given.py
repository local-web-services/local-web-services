"""Given: the secret is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the secret is "ACTIVE"')
def secret_is_active_given():
    """No-op: secrets are ACTIVE immediately after creation."""
