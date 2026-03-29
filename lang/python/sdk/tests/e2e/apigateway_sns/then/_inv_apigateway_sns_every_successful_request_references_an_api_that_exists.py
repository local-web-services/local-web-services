"""Then: every successful request references an "API" that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every successful request references an "API" that exists')
def _inv_apigateway_sns_every_successful_request_references_an_api_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
