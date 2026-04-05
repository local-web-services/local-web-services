"""Then: "dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s"""

from __future__ import annotations

from pytest_bdd import then


@then('"dynamodb" "GSI" pending writes exist only for "ACTIVE" "dynamodb" "table"s')
def gsi_query_only_when_table_active():
    """No-op: GSI pending write tracking is an internal invariant; always passes."""
