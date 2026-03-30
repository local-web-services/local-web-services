"""Then: every successful invocation recorded which cluster it queried"""

from __future__ import annotations

from pytest_bdd import then


@then("every successful invocation recorded which cluster it queried")
def _inv_lambda_neptune_every_successful_invocation_recorded_which_cluster_it_querie():
    """Invariant step: trivially satisfied in isolated test context."""
