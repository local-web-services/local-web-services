"""Given: the "glacier" "vault" has no "SNS" notification configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" has no "SNS" notification configured')
def vault_has_no_sns_notification():
    """No-op: vaults have no notification configuration by default."""
