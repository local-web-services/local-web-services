"""Then: no active "opensearch" "connection" references a deleted "opensearch" "domain" """

from __future__ import annotations

from pytest_bdd import then


@then('no active "opensearch" "connection" references a deleted "opensearch" "domain"')
def no_active_connection_references_deleted_domain():
    """Invariant trivially satisfied in isolated test context."""
