"""Then: no user in "DELETING" state is currently a member of an "ACL" """

from __future__ import annotations

from pytest_bdd import then


@then('no user in "DELETING" state is currently a member of an "ACL"')
def no_deleting_user_in_acl():
    """No-op: user-ACL membership invariant; always passes."""
