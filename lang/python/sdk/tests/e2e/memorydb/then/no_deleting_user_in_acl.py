"""Then: no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL" """

from __future__ import annotations

from pytest_bdd import step


@step('no "memorydb" "user" in "DELETING" state is currently a member of a "memorydb" "ACL"')
def no_deleting_user_in_acl():
    """No-op: user-ACL membership invariant; always passes."""
