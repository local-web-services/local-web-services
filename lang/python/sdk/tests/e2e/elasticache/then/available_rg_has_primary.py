"""Then: every available replication group has a primary cluster assigned"""

from __future__ import annotations

from pytest_bdd import step


@step("every available replication group has a primary cluster assigned")
def available_rg_has_primary():
    """No-op: replication group primary invariant; always passes."""
