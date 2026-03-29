"""Given: vid not in vault_status"""

from __future__ import annotations

from pytest_bdd import given


@given("vid not in vault_status")
def glacier_sns_vid_not_in_vault_status():
    """No-op: fresh state has no vaults."""
