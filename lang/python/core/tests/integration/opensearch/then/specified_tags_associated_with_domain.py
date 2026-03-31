"""Then: the specified tags are associated with the "elasticsearch" "domain" """

from __future__ import annotations

from pytest_bdd import then


@then('the specified tags are associated with the "opensearch" "domain"')
@then('the specified tags are associated with the "elasticsearch" "domain"')
def specified_tags_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag addition to succeed but got error: {world['error']}"
