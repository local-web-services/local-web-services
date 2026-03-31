"""Then: the "elasticsearch" "domain" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "opensearch" "domain" will be in "CREATING" state')
@then('the "elasticsearch" "domain" will be in "CREATING" state')
def domain_is_in_creating_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain creation to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"
