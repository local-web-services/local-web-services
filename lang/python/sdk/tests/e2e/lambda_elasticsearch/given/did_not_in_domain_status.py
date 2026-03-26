"""Given: did not in domain_status"""

from __future__ import annotations

from pytest_bdd import given


@given("did not in domain_status")
def did_not_in_domain_status():
    """No-op: fresh state has no Elasticsearch domains."""
