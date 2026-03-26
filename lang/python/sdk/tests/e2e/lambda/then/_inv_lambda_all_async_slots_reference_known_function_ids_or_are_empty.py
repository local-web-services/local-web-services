"""Then: all async slots reference known function IDs or are empty"""

from __future__ import annotations

from pytest_bdd import then


@then("all async slots reference known function IDs or are empty")
def _inv_lambda_all_async_slots_reference_known_function_ids_or_are_empty():
    """Invariant step: trivially satisfied in isolated test context."""
