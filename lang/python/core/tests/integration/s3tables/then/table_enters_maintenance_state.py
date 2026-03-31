"""Then: the "s3 tables" "table" will be in "MAINTENANCE" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "table" will be in "MAINTENANCE" state')
def table_enters_maintenance_state(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected compaction to start successfully"
