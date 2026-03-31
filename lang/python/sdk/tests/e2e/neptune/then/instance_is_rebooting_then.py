"""Then: the "neptune" "INSTANCE" will be in "REBOOTING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "neptune" "INSTANCE" will be in "REBOOTING" state')
def instance_is_rebooting_then(lws_session, world):
    expected_error = None
    actual_error = world.get("error")
    assert actual_error is expected_error, f"Expected reboot to succeed but got: {actual_error}"
    actual_result = world.get("result")
    expected_field = "DBInstance"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected {expected_field!r} in result but got: {actual_result}"
