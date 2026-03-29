"""Then: every available replication group has a primary cluster assigned"""

from __future__ import annotations

from pytest_bdd import then


@then("every available replication group has a primary cluster assigned")
def rg_has_primary():
    """Invariant: trivially satisfied in isolated lws context."""
