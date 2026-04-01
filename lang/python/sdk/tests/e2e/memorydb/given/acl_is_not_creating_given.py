"""Given: the "memorydb" "ACL" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" was not "CREATING"')
def acl_is_not_creating_given():
    """No-op: ACLs are not in CREATING state by default."""
