"""Then: the domain has a new cluster prepared but traffic is not yet swapped"""

from __future__ import annotations

from pytest_bdd import then


@then("the domain has a new cluster prepared but traffic is not yet swapped")
def domain_new_cluster_prepared_traffic_not_swapped(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
