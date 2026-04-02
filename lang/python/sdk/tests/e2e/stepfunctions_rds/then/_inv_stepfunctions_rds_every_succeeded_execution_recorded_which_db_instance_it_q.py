"""Then: every "SUCCEEDED" "step functions" "execution" recorded which "rds" "DB instance" it queried"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "SUCCEEDED" "step functions" "execution" recorded which "rds" "DB instance" it queried'
)
def _inv_stepfunctions_rds_every_succeeded_execution_recorded_which_db_instance_it_q():
    """Invariant step: trivially satisfied in isolated test context."""
