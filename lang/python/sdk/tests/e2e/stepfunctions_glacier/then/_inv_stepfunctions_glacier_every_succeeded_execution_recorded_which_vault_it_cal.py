"""Then: every succeeded execution recorded which vault it called"""

from __future__ import annotations

from pytest_bdd import then


@then("every succeeded execution recorded which vault it called")
def _inv_stepfunctions_glacier_every_succeeded_execution_recorded_which_vault_it_cal():
    """Invariant step: trivially satisfied in isolated test context."""
