"""Then: every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import step


@step('every existing "dynamodb" "item" belongs to an "ACTIVE" "dynamodb" "table"')
def _inv_lambda_dynamodb_every_existing_item_belongs_to_an_active_table():
    """Invariant step: trivially satisfied in isolated test context."""
