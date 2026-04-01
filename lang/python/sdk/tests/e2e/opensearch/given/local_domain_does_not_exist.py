"""Given: the local "opensearch" "domain" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the local "opensearch" "domain" did not exist')
def local_domain_does_not_exist():
    """No-op: fresh state has no domains."""
