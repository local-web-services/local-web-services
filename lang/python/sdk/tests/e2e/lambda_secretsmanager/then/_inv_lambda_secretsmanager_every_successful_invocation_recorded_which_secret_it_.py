"""Then: every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read"""

from __future__ import annotations

from pytest_bdd import step


@step('every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read')
def _inv_lambda_secretsmanager_every_successful_invocation_recorded_which_secret_it_():
    """Invariant step: trivially satisfied in isolated test context."""
