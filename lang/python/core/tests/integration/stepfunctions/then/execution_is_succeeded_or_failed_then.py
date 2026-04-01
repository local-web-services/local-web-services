"""Then: the execution will be "SUCCEEDED" or "FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution will be "SUCCEEDED" or "FAILED"')
def execution_is_succeeded_or_failed_then(world):
    assert world["error"] is None, f"Expected execution to complete but got: {world['error']}"
    actual_status = world["result"].get("status", "")
    assert actual_status in (
        "SUCCEEDED",
        "FAILED",
    ), f"Expected execution status SUCCEEDED or FAILED but got '{actual_status}'"
