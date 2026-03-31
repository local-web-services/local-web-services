"""Given: the "memorydb" "ACL" was not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" was not "MODIFYING"')
def acl_is_not_modifying():
    """No-op: ACLs are not in MODIFYING state by default."""
