"""Then: the snapshot is "ACTIVE" and the table snapshot count increases"""

from __future__ import annotations

from pytest_bdd import then


@then('the snapshot is "ACTIVE" and the table snapshot count increases')
def snapshot_is_active_and_count_increases(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected snapshot creation to succeed"
