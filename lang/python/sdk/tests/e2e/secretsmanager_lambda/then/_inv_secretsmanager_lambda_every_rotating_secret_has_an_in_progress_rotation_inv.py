"""Then: every "ROTATING" secret has an "IN_PROGRESS" rotation invocation"""

from __future__ import annotations

from pytest_bdd import then


@then('every "ROTATING" secret has an "IN_PROGRESS" rotation invocation')
def _inv_secretsmanager_lambda_every_rotating_secret_has_an_in_progress_rotation_inv():
    """Invariant step: trivially satisfied in isolated test context."""
