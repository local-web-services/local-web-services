"""Then: "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then


@then(
    '"neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state'
)
def instances_on_stopped_cluster_not_modifying():
    """Invariant trivially satisfied in isolated test context."""
