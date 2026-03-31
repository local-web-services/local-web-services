"""Given: the "elasticsearch" "domain" is being deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" is being deleted')
def elasticsearch_seq_domain_deleted():
    """No-op: fresh state has no domains, simulates a previously deleted domain."""
