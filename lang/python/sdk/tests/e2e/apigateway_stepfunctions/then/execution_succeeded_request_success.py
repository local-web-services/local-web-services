"""Then: the execution is "SUCCEEDED" and the request is "SUCCESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution is "SUCCEEDED" and the request is "SUCCESS"')
def execution_succeeded_request_success(world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
