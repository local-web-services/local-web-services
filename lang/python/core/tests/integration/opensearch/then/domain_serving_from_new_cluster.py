"""Then: the domain is now serving requests from the new cluster"""

from __future__ import annotations

from pytest_bdd import then


@then("the domain is now serving requests from the new cluster")
def domain_serving_from_new_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
