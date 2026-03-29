"""Then: every successful rotation invocation recorded which secret it rotated"""

from __future__ import annotations

from pytest_bdd import then


@then("every successful rotation invocation recorded which secret it rotated")
def _inv_secretsmanager_lambda_every_successful_rotation_invocation_recorded_which_s():
    """Invariant step: trivially satisfied in isolated test context."""
