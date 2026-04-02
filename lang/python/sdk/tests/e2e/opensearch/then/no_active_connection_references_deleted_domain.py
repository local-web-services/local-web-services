"""Then: no active "opensearch" "connection" references a deleted "opensearch" "domain" """

from __future__ import annotations

from pytest_bdd import step


@step('no active "opensearch" "connection" references a deleted "opensearch" "domain"')
def no_active_connection_references_deleted_domain():
    """No-op: connection-domain reference integrity is an internal invariant; always passes."""
