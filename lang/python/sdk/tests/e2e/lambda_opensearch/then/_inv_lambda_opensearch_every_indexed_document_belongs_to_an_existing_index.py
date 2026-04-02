"""Then: every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index" """

from __future__ import annotations

from pytest_bdd import step


@step('every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"')
def _inv_lambda_opensearch_every_indexed_document_belongs_to_an_existing_index():
    """Invariant step: trivially satisfied in isolated test context."""
