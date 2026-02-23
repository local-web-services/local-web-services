"""DynamoDB helper for seeding and asserting table state."""

from __future__ import annotations

from typing import Any


class DynamoDBHelper:
    """Convenience wrapper for a single DynamoDB table.

    Usage::

        table = session.dynamodb("Orders")
        table.put({"id": {"S": "1"}, "status": {"S": "pending"}})
        items = table.scan()
        assert len(items) == 1
    """

    def __init__(self, table_name: str, client: Any) -> None:
        self._table_name = table_name
        self._client = client

    def put(self, item: dict[str, Any]) -> None:
        """Write *item* into the table (DynamoDB attribute-value format)."""
        self._client.put_item(TableName=self._table_name, Item=item)

    def get(self, key: dict[str, Any]) -> dict[str, Any] | None:
        """Return the item matching *key*, or ``None`` if not found."""
        response = self._client.get_item(TableName=self._table_name, Key=key)
        return response.get("Item")

    def delete(self, key: dict[str, Any]) -> None:
        """Delete the item matching *key*."""
        self._client.delete_item(TableName=self._table_name, Key=key)

    def scan(self) -> list[dict[str, Any]]:
        """Return all items in the table."""
        items: list[dict[str, Any]] = []
        paginator = self._client.get_paginator("scan")
        for page in paginator.paginate(TableName=self._table_name):
            items.extend(page.get("Items", []))
        return items

    def query(self, **kwargs: Any) -> list[dict[str, Any]]:
        """Run a query and return the result items.

        All kwargs are forwarded to ``boto3.client.query`` together with the
        pre-configured ``TableName``.
        """
        response = self._client.query(TableName=self._table_name, **kwargs)
        return response.get("Items", [])

    def assert_item_exists(self, key: dict[str, Any]) -> dict[str, Any]:
        """Assert that an item matching *key* exists; return the item."""
        item = self.get(key)
        assert item is not None, (
            f"Expected item with key {key} in table {self._table_name!r} "
            "to exist, but it was not found."
        )
        return item

    def assert_item_count(self, expected_count: int) -> None:
        """Assert that the table contains exactly *expected_count* items."""
        actual_items = self.scan()
        actual_count = len(actual_items)
        assert actual_count == expected_count, (
            f"Expected {expected_count} item(s) in table {self._table_name!r}, "
            f"but found {actual_count}."
        )
