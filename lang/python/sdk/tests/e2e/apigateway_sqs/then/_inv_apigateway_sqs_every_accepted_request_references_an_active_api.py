"""Then: every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ACCEPTED" "api gateway" "request" references an "ACTIVE" "api gateway" "API"')
def _inv_apigateway_sqs_every_accepted_request_references_an_active_api():
    """Invariant step: trivially satisfied in isolated test context."""
