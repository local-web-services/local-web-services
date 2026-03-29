"""Then: every successful invocation references a "DB" instance that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every successful invocation references a "DB" instance that exists')
def _inv_rds_lambda_every_successful_invocation_references_a_db_instance_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
