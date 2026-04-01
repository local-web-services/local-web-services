"""Given: the "memorydb" "user" was not already a member of the "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was not already a member of the "memorydb" "ACL"')
def user_is_not_already_member_of_acl():
    """No-op: users are not ACL members by default."""
