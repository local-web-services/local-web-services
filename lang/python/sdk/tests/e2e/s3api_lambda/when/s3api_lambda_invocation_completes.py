"""When: the "lambda" "function" invocation completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation completes successfully')
def s3api_lambda_invocation_completes(world):
    """Internal scenario: invocation completes are not observable via public API."""
    if world.get("error") is not None:
        return
    world["error"] = Exception(
        "Internal scenario: invocation completion not testable via public API"
    )
