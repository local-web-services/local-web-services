"""Then: the "elasticsearch" "domain" will be "ACTIVE" and ready for use"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "domain" will be "ACTIVE" and ready for use')
def es_domain_is_active_ready_for_use(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
