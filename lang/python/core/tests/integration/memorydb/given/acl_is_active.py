"""Given: the "memorydb" "ACL" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "ACL" was "ACTIVE"')
@given('the "memorydb" "ACL" will be "ACTIVE"')
def acl_is_active():
    """No-op: ACLs are ACTIVE immediately after creation in lws."""
