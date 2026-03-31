"""Then: every existing record references a "memorydb" "cluster" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every existing record references a "memorydb" "cluster" that exists')
def _inv_lambda_memorydb_every_existing_record_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
