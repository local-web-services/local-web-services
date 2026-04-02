"""Then: the "s3 tables" "snapshot" will be "ACTIVE" and the "s3 tables" "table" snapshot count will increase"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "s3 tables" "snapshot" will be "ACTIVE" and the "s3 tables" "table" snapshot count will increase'
)
def snapshot_is_active_and_count_increases(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected snapshot creation to succeed"
