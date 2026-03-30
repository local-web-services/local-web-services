"""Then: the secret can no longer be restored"""

from __future__ import annotations

from pytest_bdd import then


@then("the secret can no longer be restored")
def secret_cannot_be_restored(world):
    assert (
        world["error"] is None
    ), f"Expected recovery_window_expires action to succeed but got: {world['error']}"
