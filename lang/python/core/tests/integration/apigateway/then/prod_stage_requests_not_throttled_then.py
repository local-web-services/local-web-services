"""Then: prod stage requests are not throttled"""

from __future__ import annotations

from pytest_bdd import then


@then("prod stage requests are not throttled")
def prod_stage_requests_not_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"
