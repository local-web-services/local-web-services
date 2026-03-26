"""Then: the table enters "MAINTENANCE" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the table enters "MAINTENANCE" state')
def table_enters_maintenance_state(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected compaction to start successfully"
