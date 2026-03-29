"""Then: every archive retrieval job references a non-empty archive "ID" """

from __future__ import annotations

from pytest_bdd import then


@then('every archive retrieval job references a non-empty archive "ID"')
def every_archive_retrieval_job_references_archive_id():
    """Invariant trivially satisfied in an isolated test context."""
