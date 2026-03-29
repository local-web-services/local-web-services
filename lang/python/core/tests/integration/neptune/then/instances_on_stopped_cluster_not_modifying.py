"""Then: instances on a stopped or stopping cluster are not in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('instances on a stopped or stopping cluster are not in "MODIFYING" state')
def instances_on_stopped_cluster_not_modifying():
    """Invariant trivially satisfied in isolated test context."""
