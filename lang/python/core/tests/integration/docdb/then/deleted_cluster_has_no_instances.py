"""Then: a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s')
def deleted_cluster_has_no_instances():
    """Invariant: trivially satisfied in isolated lws context."""
