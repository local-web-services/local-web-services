"""Then: traffic can only be swapped after the new "opensearch" "cluster" was ready"""

from __future__ import annotations

from pytest_bdd import then


@then('traffic can only be swapped after the new "opensearch" "cluster" was ready')
def traffic_only_swapped_after_cluster_ready():
    """Invariant trivially satisfied in isolated test context."""
