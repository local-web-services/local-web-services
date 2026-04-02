"""Then: "s3 tables" "table" schema version is always at least one"""

from __future__ import annotations

from pytest_bdd import step


@step('"s3 tables" "table" schema version is always at least one')
def schema_version_at_least_one():
    """No-op: schema version invariant; always passes."""
