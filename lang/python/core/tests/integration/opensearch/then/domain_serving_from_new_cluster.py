"""Then: the "opensearch" "domain" will now be serving requests from the new "opensearch" "cluster" """

from __future__ import annotations

from pytest_bdd import then


@then('the "opensearch" "domain" will now be serving requests from the new "opensearch" "cluster"')
def domain_serving_from_new_cluster(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
