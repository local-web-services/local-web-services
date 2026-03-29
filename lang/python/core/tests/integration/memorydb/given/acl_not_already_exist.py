"""Given: the "ACL" does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "ACL" does not already exist')
def acl_not_already_exist():
    """No-op: fresh state has no ACLs."""
