"""Given: the "ACL" is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ACL" is not "CREATING"')
def acl_is_not_creating_given():
    """No-op: ACLs are not in CREATING state by default."""
