"""Given: the "ACL" does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ACL" does not exist')
def acl_does_not_exist():
    """No-op: fresh state has no ACLs."""
