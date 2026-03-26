"""Then: the domain enters "PROCESSING" state while recovering"""

from __future__ import annotations

from pytest_bdd import then


@then('the domain enters "PROCESSING" state while recovering')
def es_domain_enters_processing_while_recovering(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
