"""Given: the remote domain does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the remote domain does not exist")
def remote_domain_does_not_exist():
    """No-op: fresh state has no domains."""
