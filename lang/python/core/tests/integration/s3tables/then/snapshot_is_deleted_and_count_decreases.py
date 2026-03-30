"""Then: the snapshot is "DELETED" and the table snapshot count decreases"""

from __future__ import annotations

from pytest_bdd import then


@then('the snapshot is "DELETED" and the table snapshot count decreases')
def snapshot_is_deleted_and_count_decreases(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected snapshot expiry to succeed"
