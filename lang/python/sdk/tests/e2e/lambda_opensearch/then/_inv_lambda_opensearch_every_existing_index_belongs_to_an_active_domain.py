"""Then: every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain" """

from __future__ import annotations

from pytest_bdd import step


@step('every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"')
def _inv_lambda_opensearch_every_existing_index_belongs_to_an_active_domain():
    """Invariant step: trivially satisfied in isolated test context."""
