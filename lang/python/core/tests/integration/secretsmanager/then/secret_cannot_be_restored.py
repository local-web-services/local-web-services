"""Then: the "secrets manager" "secret" can no longer be restored"""

from __future__ import annotations

from pytest_bdd import then


@then('the "secrets manager" "secret" can no longer be restored')
def secret_cannot_be_restored(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected recovery_window_expires action to succeed but got: {actual_error}"
