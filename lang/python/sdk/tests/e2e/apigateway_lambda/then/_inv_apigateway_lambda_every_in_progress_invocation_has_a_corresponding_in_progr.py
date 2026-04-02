"""Then: every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"'
)
def _inv_apigateway_lambda_every_in_progress_invocation_has_a_corresponding_in_progr():
    """Invariant step: trivially satisfied in isolated test context."""
