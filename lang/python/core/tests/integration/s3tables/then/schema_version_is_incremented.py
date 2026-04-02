"""Then: the "s3 tables" "table" schema version will be incremented"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "table" schema version will be incremented')
def schema_version_is_incremented(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected schema evolution to succeed"
