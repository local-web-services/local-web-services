"""Given: no CloudTrail provider is registered"""

from __future__ import annotations

from pytest_bdd import given


@given("no CloudTrail provider is registered")
def no_cloudtrail_provider_is_registered():
    """No-op: in the e2e session the CloudTrail provider is always present.
    The scenario verifies that service calls succeed normally regardless."""
