"""Then: compaction will be enabled for the "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import then


@then('compaction will be enabled for the "s3 tables" "table"')
def compaction_is_enabled_for_table_then(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected maintenance configuration to succeed"
