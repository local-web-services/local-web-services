"""Given: the "memorydb" "ACL" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" was "ACTIVE"')
def acl_is_active_given():
    """No-op: ACLs are ACTIVE immediately after creation in lws."""
