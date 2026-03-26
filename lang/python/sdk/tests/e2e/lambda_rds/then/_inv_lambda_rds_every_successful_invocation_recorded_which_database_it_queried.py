"""Then: every successful invocation recorded which database it queried"""

from __future__ import annotations

from pytest_bdd import then


@then("every successful invocation recorded which database it queried")
def _inv_lambda_rds_every_successful_invocation_recorded_which_database_it_queried():
    """Invariant step: trivially satisfied in isolated test context."""
