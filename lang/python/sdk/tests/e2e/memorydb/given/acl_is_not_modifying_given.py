"""Given: the "ACL" is not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ACL" is not "MODIFYING"')
def acl_is_not_modifying_given():
    """No-op: ACLs are not in MODIFYING state by default."""
