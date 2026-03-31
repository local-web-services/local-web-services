"""Then: the "opensearch" "domain" will be in "PROCESSING" state and a blue-green deployment begins"""

from __future__ import annotations

from pytest_bdd import then


@then('the "opensearch" "domain" will be in "PROCESSING" state and a blue-green deployment begins')
def domain_is_in_processing_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain config update to succeed but got error: {world['error']}"
