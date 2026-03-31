"""Given: the "glacier" "vault" had no in-progress jobs"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" had no in-progress jobs')
def vault_has_no_in_progress_jobs():
    """No-op: freshly created vaults have no jobs."""
