"""Given: a search domain has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("a search domain has been deleted")
def elasticsearch_seq_domain_deleted():
    """No-op: fresh state has no domains, simulates a previously deleted domain."""
