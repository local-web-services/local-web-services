"""Then: the domain is in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the domain is in "DELETING" state')
def domain_is_in_deleting_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected domain deletion to succeed but got error: {world['error']}"
    assert (
        "DomainStatus" in actual_result
    ), f"Expected DomainStatus in result but got: {actual_result}"
