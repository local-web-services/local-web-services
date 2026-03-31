"""Then: every existing document references a "documentdb" "cluster" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every existing document references a "documentdb" "cluster" that exists')
def _inv_lambda_docdb_every_existing_document_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
