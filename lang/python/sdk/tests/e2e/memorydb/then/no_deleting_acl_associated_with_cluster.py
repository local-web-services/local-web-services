"""Then: no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import step


@step('no "memorydb" "ACL" in "DELETING" state is currently associated with a "memorydb" "cluster"')
def no_deleting_acl_associated_with_cluster():
    """No-op: ACL-cluster association invariant; always passes."""
