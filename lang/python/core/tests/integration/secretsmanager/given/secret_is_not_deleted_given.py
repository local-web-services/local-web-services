"""Given: the "secrets manager" "secret" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "secrets manager" "secret" was not "DELETED"')
def secret_is_not_deleted_given():
    """No-op: freshly created secrets are ACTIVE, not DELETED."""
