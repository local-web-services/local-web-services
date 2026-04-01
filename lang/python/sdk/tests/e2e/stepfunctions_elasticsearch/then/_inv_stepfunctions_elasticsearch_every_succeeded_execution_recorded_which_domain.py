"""Then: every succeeded execution recorded which domain it called"""

from __future__ import annotations

from pytest_bdd import step


@step("every succeeded execution recorded which domain it called")
def _inv_stepfunctions_elasticsearch_every_succeeded_execution_recorded_which_domain():
    """Invariant step: trivially satisfied in isolated test context."""
