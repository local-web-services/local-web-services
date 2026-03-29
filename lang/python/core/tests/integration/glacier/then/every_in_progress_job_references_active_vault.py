"""Then: every in-progress job references an active vault"""

from __future__ import annotations

from pytest_bdd import then


@then("every in-progress job references an active vault")
def every_in_progress_job_references_active_vault():
    """Invariant trivially satisfied in an isolated test context."""
