"""Given: the local and remote domains are different"""

from __future__ import annotations

from pytest_bdd import given


@given("the local and remote domains are different")
def local_and_remote_domains_are_different():
    """No-op: INT_DOMAIN and INT_DOMAIN2 are different names."""
