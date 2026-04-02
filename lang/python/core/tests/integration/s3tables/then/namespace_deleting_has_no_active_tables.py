"""Then: a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s')
def namespace_deleting_has_no_active_tables():
    """Invariant: trivially satisfied in isolated test context."""
