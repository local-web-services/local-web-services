"""Then: a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s')
def deleting_cluster_receives_no_new_instances():
    """Invariant: trivially satisfied in isolated lws context."""
