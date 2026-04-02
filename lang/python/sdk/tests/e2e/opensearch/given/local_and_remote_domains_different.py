"""Given: the local and remote "opensearch" "domain"s are different"""

from __future__ import annotations

from pytest_bdd import given


@given('the local and remote "opensearch" "domain"s are different')
def local_and_remote_domains_different():
    """No-op: domains are different by default."""
