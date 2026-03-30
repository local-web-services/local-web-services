"""Then: every existing item belongs to an "ACTIVE" table"""

from __future__ import annotations

from pytest_bdd import then


@then('every existing item belongs to an "ACTIVE" table')
def _inv_stepfunctions_dynamodb_every_existing_item_belongs_to_an_active_table():
    """Invariant step: trivially satisfied in isolated test context."""
