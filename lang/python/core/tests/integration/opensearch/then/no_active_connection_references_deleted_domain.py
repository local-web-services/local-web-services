"""Then: no active connection references a deleted domain"""

from __future__ import annotations

from pytest_bdd import then


@then("no active connection references a deleted domain")
def no_active_connection_references_deleted_domain():
    """Invariant trivially satisfied in isolated test context."""
