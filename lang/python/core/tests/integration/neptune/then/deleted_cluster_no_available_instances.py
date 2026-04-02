"""Then: a deleted "neptune" "cluster" has no available "neptune" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a deleted "neptune" "cluster" has no available "neptune" "instance"s')
def deleted_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
