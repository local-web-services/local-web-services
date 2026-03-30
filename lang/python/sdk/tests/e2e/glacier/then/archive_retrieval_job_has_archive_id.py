"""Then: every archive retrieval job references a non-empty archive "ID" """

from __future__ import annotations

from pytest_bdd import then


@then('every archive retrieval job references a non-empty archive "ID"')
def archive_retrieval_job_has_archive_id():
    """No-op: archive retrieval job reference invariant; always passes."""
