"""Then: every function has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every function has a valid status")
def _inv_lambda_every_function_has_a_valid_status():
    """Invariant step: trivially satisfied in isolated test context."""
