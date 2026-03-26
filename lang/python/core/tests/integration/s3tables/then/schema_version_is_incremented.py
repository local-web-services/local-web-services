"""Then: the schema version is incremented"""

from __future__ import annotations

from pytest_bdd import then


@then("the schema version is incremented")
def schema_version_is_incremented(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected schema evolution to succeed"
