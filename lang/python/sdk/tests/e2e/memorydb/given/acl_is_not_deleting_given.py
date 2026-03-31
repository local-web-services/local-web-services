"""Given: the "memorydb" "ACL" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" was not "DELETING"')
def acl_is_not_deleting_given():
    """No-op: ACLs are not in DELETING state by default."""
