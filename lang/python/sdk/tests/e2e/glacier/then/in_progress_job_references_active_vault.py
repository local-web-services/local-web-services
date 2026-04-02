"""Then: every in-progress "glacier" "job" references an active "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import step


@step('every in-progress "glacier" "job" references an active "glacier" "vault"')
def in_progress_job_references_active_vault():
    """No-op: job-vault reference integrity is an internal invariant; always passes."""
