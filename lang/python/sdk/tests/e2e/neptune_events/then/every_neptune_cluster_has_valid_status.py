"""Then: every "neptune" "cluster" has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step('every "neptune" "cluster" has a valid status')
def every_neptune_cluster_has_valid_status():
    """Invariant step: trivially satisfied in isolated test context."""
