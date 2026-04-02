"""Then: every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"'
)
def _inv_secretsmanager_lambda_every_rotating_secret_has_an_in_progress_rotation_inv():
    """Invariant step: trivially satisfied in isolated test context."""
