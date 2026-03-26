"""Given: the vault does not exist or is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the vault does not exist or is "DELETED"')
def vault_does_not_exist_or_deleted_given():
    """No-op: fresh state has no Glacier vaults."""
