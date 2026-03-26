"""Given: compaction is not enabled for the table"""

from __future__ import annotations

from pytest_bdd import given


@given("compaction is not enabled for the table")
def compaction_is_not_enabled_for_table():
    """No-op: compaction is not enabled by default."""
