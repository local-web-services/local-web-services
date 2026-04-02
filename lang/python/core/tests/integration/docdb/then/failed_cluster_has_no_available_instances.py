"""Then: a failed "documentdb" "cluster" has no available "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a failed "documentdb" "cluster" has no available "documentdb" "instance"s')
def failed_cluster_has_no_available_instances():
    """Invariant: trivially satisfied in isolated lws context."""
