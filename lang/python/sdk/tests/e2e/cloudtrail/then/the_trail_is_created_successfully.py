"""Then: the trail is created successfully"""

from __future__ import annotations

from pytest_bdd import then


@then("the trail is created successfully")
def the_trail_is_created_successfully(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected trail creation to succeed but got error: {actual_error}"
