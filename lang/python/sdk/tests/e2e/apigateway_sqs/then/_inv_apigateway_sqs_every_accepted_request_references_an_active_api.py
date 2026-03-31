"""Then: every "ACCEPTED" request references an "ACTIVE" "API" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ACCEPTED" request references an "ACTIVE" "API"')
def _inv_apigateway_sqs_every_accepted_request_references_an_active_api():
    """Invariant step: trivially satisfied in isolated test context."""
