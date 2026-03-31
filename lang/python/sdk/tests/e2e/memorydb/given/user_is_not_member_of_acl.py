"""Given: the "memorydb" "user" was not a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was not a member of the "memorydb" "ACL"')
def user_is_not_member_of_acl():
    """No-op: users are not ACL members by default."""
