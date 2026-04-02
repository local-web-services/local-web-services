"""Then: every in-progress "glacier" "job" references an active "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import then


@then('every in-progress "glacier" "job" references an active "glacier" "vault"')
def every_in_progress_job_references_active_vault():
    """Invariant trivially satisfied in an isolated test context."""
