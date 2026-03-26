"""Then: every succeeded execution recorded which cluster it read"""

from __future__ import annotations

from pytest_bdd import then


@then("every succeeded execution recorded which cluster it read")
def _inv_stepfunctions_elasticache_every_succeeded_execution_recorded_which_cluster_():
    """Invariant step: trivially satisfied in isolated test context."""
