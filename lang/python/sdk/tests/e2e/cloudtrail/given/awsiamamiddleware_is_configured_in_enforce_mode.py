"""Given: AwsIamAuthMiddleware is configured in enforce mode"""

from __future__ import annotations

from pytest_bdd import given


@given("AwsIamAuthMiddleware is configured in enforce mode")
def awsiamamiddleware_is_configured_in_enforce_mode():
    """No-op: IAM enforcement is not reconfigurable per-scenario in the e2e session."""
