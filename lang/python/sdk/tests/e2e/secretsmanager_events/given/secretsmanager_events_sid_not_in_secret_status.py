"""Given: sid not in secret_status"""

from __future__ import annotations

from pytest_bdd import given


@given("sid not in secret_status")
def secretsmanager_events_sid_not_in_secret_status():
    """No-op: fresh state has no secrets."""
