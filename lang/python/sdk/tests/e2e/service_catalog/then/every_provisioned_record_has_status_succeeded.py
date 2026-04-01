"""Then: every provisioned record has status "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then


@then('every provisioned record has status "SUCCEEDED"')
def every_provisioned_record_has_status_succeeded(world):
    """Verify the current result record has Status=SUCCEEDED (invariant check)."""
    expected_status = "SUCCEEDED"
    actual_status = world["result"]["RecordDetail"]["Status"]
    assert (
        actual_status == expected_status
    ), f"Expected {expected_status!r} but got {actual_status!r}"
