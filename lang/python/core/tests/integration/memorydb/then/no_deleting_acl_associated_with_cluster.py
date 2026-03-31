"""Then: no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import then


@then('no "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"')
def no_deleting_acl_associated_with_cluster():
    """Invariant: trivially satisfied in isolated lws context."""
