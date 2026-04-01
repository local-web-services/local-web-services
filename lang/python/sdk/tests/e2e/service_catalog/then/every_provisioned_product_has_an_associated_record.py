"""Then: every provisioned product has an associated record"""

from __future__ import annotations

from pytest_bdd import then


@then("every provisioned product has an associated record")
def every_provisioned_product_has_an_associated_record(world):
    """Verify the result contains a RecordId (invariant check)."""
    expected_record_id_present = True
    actual_record_id_present = bool(world["result"]["RecordDetail"].get("RecordId"))
    assert (
        actual_record_id_present == expected_record_id_present
    ), "Expected RecordId to be present in RecordDetail"
