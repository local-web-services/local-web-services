"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def s3api_lambda_invocation_is_in_progress(world):
    """Internal state not reachable via public API; mark scenario as N/A."""
    world["result"] = None
    world["error"] = Exception("Internal scenario: invocation state not accessible via public API")
