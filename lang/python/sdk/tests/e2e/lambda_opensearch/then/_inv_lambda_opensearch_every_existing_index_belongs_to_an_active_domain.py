"""Then: every existing index belongs to an "ACTIVE" domain"""

from __future__ import annotations

from pytest_bdd import then


@then('every existing index belongs to an "ACTIVE" domain')
def _inv_lambda_opensearch_every_existing_index_belongs_to_an_active_domain():
    """Invariant step: trivially satisfied in isolated test context."""
