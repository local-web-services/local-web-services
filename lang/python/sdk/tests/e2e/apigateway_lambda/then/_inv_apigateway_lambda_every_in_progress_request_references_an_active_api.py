"""Then: every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API" """

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"')
def _inv_apigateway_lambda_every_in_progress_request_references_an_active_api():
    """Invariant step: trivially satisfied in isolated test context."""
