"""Then: "api gateway" "prod stage" requests will be throttled"""

from __future__ import annotations

from pytest_bdd import then


@then('"api gateway" "prod stage" requests will be throttled')
def prod_stage_requests_throttled_then(world):
    assert (
        world["error"] is None
    ), f"Expected throttling update to succeed but got error: {world['error']}"
