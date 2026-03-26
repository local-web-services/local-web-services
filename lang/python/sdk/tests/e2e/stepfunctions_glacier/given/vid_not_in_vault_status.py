"""Given: vid not in vault_status"""

from __future__ import annotations

from pytest_bdd import given


@given("vid not in vault_status")
def vid_not_in_vault_status():
    """No-op: guard condition — fresh state has no Glacier vaults."""
