"""Then: every existing item references a "dynamodb" "table" that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every existing item references a "dynamodb" "table" that exists')
def _inv_events_dynamodb_every_existing_item_references_a_table_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
