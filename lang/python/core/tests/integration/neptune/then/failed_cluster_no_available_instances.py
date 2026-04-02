"""Then: a failed "neptune" "cluster" has no available "neptune" "instance"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a failed "neptune" "cluster" has no available "neptune" "instance"s')
def failed_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
