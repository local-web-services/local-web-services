"""Given: compaction was not "ENABLED" for the "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import given


@given('compaction was not "ENABLED" for the "s3 tables" "table"')
def compaction_is_not_enabled_for_table():
    """No-op: compaction is not enabled by default."""
