"""Then: the message visibility is updated"""

from __future__ import annotations

from pytest_bdd import then


@then("the message visibility is updated")
def message_visibility_updated_then(world):
    assert (
        world["error"] is None
    ), f"Expected visibility update to succeed but got: {world['error']}"
