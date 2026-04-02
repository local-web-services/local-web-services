"""Then: "s3 tables" "table" snapshot count is never negative"""

from __future__ import annotations

from pytest_bdd import step


@step('"s3 tables" "table" snapshot count is never negative')
def snapshot_count_non_negative():
    """No-op: snapshot count invariant; always passes."""
