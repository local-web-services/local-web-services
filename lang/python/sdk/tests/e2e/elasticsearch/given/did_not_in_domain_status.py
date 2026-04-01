"""Given: domain not in domain_status"""

from __future__ import annotations

from pytest_bdd import given


@given("domain not in domain_status")
def did_not_in_domain_status():
    """No-op: fresh state has no domains."""
