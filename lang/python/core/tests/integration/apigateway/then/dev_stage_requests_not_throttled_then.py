"""Then: dev stage requests are not throttled"""

from __future__ import annotations

from pytest_bdd import then


@then("dev stage requests are not throttled")
def dev_stage_requests_not_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"
