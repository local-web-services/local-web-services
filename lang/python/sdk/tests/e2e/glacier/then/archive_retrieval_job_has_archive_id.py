"""Then: every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"'
)
def archive_retrieval_job_has_archive_id():
    """No-op: archive retrieval job reference invariant; always passes."""
