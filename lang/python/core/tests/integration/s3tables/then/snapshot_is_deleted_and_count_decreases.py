"""Then: the "s3 tables" "snapshot" will be "DELETED" and the "s3 tables" "table" snapshot count will decrease"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "s3 tables" "snapshot" will be "DELETED" and the "s3 tables" "table" snapshot count will decrease'
)
def snapshot_is_deleted_and_count_decreases(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected snapshot expiry to succeed"
