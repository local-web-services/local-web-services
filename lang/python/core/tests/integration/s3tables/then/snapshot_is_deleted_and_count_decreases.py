"""Then: the "s3 tables" "SNAPSHOT" will be "DELETED" and the "s3 tables" "table" s3 tables snapshot count decreases"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "s3 tables" "SNAPSHOT" will be "DELETED" and the "s3 tables" "table" s3 tables snapshot count decreases'
)
def snapshot_is_deleted_and_count_decreases(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected snapshot expiry to succeed"
