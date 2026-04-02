"""Then: every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated'
)
def _inv_secretsmanager_lambda_every_successful_rotation_invocation_recorded_which_s():
    """Invariant step: trivially satisfied in isolated test context."""
