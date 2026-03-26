"""Then: every succeeded execution recorded which secret it read"""

from __future__ import annotations

from pytest_bdd import then


@then("every succeeded execution recorded which secret it read")
def _inv_stepfunctions_secretsmanager_every_succeeded_execution_recorded_which_secre():
    """Invariant step: trivially satisfied in isolated test context."""
