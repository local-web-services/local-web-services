"""Given: the "ACL" is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "ACL" is "ACTIVE"')
def acl_is_active_given():
    """No-op: ACLs are ACTIVE immediately after creation in lws."""
