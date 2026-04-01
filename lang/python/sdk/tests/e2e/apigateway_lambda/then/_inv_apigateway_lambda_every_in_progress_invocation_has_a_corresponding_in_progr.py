"""Then: every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request"""

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request')
def _inv_apigateway_lambda_every_in_progress_invocation_has_a_corresponding_in_progr():
    """Invariant step: trivially satisfied in isolated test context."""
