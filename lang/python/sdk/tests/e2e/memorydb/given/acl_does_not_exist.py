"""Given: the "memorydb" "ACL" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" did not exist')
def acl_does_not_exist():
    """No-op: fresh state has no ACLs."""
