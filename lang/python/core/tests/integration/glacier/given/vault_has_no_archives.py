"""Given: the "glacier" "vault" had no archives"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" had no archives')
def vault_has_no_archives():
    """No-op: freshly created vaults have zero archives."""
