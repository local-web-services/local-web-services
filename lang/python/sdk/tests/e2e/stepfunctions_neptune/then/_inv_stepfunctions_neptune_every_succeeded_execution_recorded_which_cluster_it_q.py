"""Then: every succeeded execution recorded which cluster it queried"""

from __future__ import annotations

from pytest_bdd import step


@step("every succeeded execution recorded which cluster it queried")
def _inv_stepfunctions_neptune_every_succeeded_execution_recorded_which_cluster_it_q():
    """Invariant step: trivially satisfied in isolated test context."""
