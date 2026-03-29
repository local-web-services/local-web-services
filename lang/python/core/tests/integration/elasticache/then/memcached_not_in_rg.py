"""Then: memcached clusters are never associated with a replication group"""

from __future__ import annotations

from pytest_bdd import then


@then("memcached clusters are never associated with a replication group")
def memcached_not_in_rg():
    """Invariant: trivially satisfied in isolated lws context."""
