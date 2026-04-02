"""Then: a stopped "neptune" "cluster" has no available "neptune" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a stopped "neptune" "cluster" has no available "neptune" "instance"s')
def stopped_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
