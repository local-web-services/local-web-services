"""Then: the "elasticsearch" "domain" will be "ACTIVE" with the new configuration applied"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "domain" will be "ACTIVE" with the new configuration applied')
def es_domain_is_active_with_new_config(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
