"""Then: the "sns" "message" will be "PUBLISHED" and the "api gateway" "request" will be "SUCCESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the "sns" "message" will be "PUBLISHED" and the "api gateway" "request" will be "SUCCESS"')
def message_published_request_success(world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
