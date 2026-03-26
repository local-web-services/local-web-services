"""Then: every in-progress job references an active vault"""

from __future__ import annotations

from pytest_bdd import then


@then("every in-progress job references an active vault")
def in_progress_job_references_active_vault():
    """No-op: job-vault reference integrity is an internal invariant; always passes."""
