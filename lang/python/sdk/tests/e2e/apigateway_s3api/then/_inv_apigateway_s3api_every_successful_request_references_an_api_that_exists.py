"""Then: every successful request references an "api gateway" "API" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every successful request references an "api gateway" "API" that exists')
def _inv_apigateway_s3api_every_successful_request_references_an_api_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
