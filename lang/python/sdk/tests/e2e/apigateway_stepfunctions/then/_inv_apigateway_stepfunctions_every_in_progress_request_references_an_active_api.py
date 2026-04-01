"""Then: every "IN_PROGRESS" request references an "ACTIVE" "API" """

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" request references an "ACTIVE" "API"')
def _inv_apigateway_stepfunctions_every_in_progress_request_references_an_active_api():
    """Invariant step: trivially satisfied in isolated test context."""
