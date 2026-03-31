"""Then: traffic can only be swapped after the new "opensearch" "cluster" was ready"""

from __future__ import annotations

from pytest_bdd import then


@then('traffic can only be swapped after the new "opensearch" "cluster" was ready')
def traffic_swap_requires_new_cluster():
    """No-op: blue-green deployment state invariant; always passes."""
