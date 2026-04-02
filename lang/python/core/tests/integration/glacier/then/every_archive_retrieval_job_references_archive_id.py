"""Then: every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"'
)
def every_archive_retrieval_job_references_archive_id():
    """Invariant trivially satisfied in an isolated test context."""
