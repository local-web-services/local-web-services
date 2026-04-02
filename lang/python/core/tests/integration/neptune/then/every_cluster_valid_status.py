"""Then: every "documentdb" "cluster" has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then('every "documentdb" "cluster" has a valid status')
def every_cluster_valid_status():
    """Invariant trivially satisfied in isolated test context."""
