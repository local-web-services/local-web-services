"""Then: the "service_catalog" "record" will be "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "service_catalog" "record" will be "SUCCEEDED"')
@then('the "service catalog" "record" will be "SUCCEEDED"')
def service_catalog_record_will_be_succeeded(world):
    """Verify the RecordDetail returned has Status=SUCCEEDED."""
    expected_status = "SUCCEEDED"
    actual_status = world["result"]["RecordDetail"]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected {expected_status!r} but got {actual_status!r}"
