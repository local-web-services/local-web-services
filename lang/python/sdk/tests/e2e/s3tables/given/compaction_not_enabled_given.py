"""Given: compaction is not enabled for the table"""

from __future__ import annotations

from pytest_bdd import given


@given("compaction is not enabled for the table")
def compaction_not_enabled_given():
    """No-op: compaction is not enabled by default."""
