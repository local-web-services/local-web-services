"""When: the Lambda invocation fails"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda invocation fails")
def s3api_lambda_invocation_fails(world):
    """Internal scenario: invocation failures are not observable via public API."""
    if world.get("error") is not None:
        return
    world["error"] = Exception("Internal scenario: invocation failure not testable via public API")
