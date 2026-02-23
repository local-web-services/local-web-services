"""IKeyValueStore interface for DynamoDB-like table operations."""

from abc import abstractmethod
from dataclasses import dataclass, field

from lws.interfaces.provider import Provider


@dataclass
class KeyAttribute:
    """Definition of a key attribute (partition or sort key)."""

    name: str
    type: str  # S, N, or B


@dataclass
class KeySchema:
    """Key schema for a table or index."""

    partition_key: KeyAttribute
    sort_key: KeyAttribute | None = None


@dataclass
class GsiDefinition:
    """Definition of a Global Secondary Index."""

    index_name: str
    key_schema: KeySchema
    projection_type: str = "ALL"


@dataclass
class TableConfig:
    """Configuration for a key-value store table."""

    table_name: str
    key_schema: KeySchema
    gsi_definitions: list[GsiDefinition] = field(default_factory=list)


class IKeyValueStore(Provider):
    """Abstract interface for key-value store providers (DynamoDB-like).

    Implementations provide table-oriented CRUD, query, scan,
    and batch operations against a local or remote store.
    """

    @abstractmethod
    async def put_item(self, table_name: str, item: dict) -> None:
        """Put a single item into the specified table."""

    @abstractmethod
    async def get_item(self, table_name: str, key: dict) -> dict | None:
        """Get a single item by its key. Returns None if not found."""

    @abstractmethod
    async def delete_item(self, table_name: str, key: dict) -> None:
        """Delete a single item by its key."""

    @abstractmethod
    async def update_item(
        self,
        table_name: str,
        key: dict,
        update_expression: str,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
    ) -> dict:
        """Update an item and return the updated item."""

    @abstractmethod
    async def query(
        self,
        table_name: str,
        key_condition: str,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
        index_name: str | None = None,
        filter_expression: str | None = None,
    ) -> list[dict]:
        """Query items by key condition expression."""

    @abstractmethod
    async def scan(
        self,
        table_name: str,
        filter_expression: str | None = None,
        expression_values: dict | None = None,
        expression_names: dict | None = None,
    ) -> list[dict]:
        """Scan all items in a table, optionally filtering."""

    @abstractmethod
    async def batch_get_items(self, table_name: str, keys: list[dict]) -> list[dict]:
        """Get multiple items by their keys in a single batch."""

    @abstractmethod
    async def batch_write_items(
        self,
        table_name: str,
        put_items: list[dict] | None = None,
        delete_keys: list[dict] | None = None,
    ) -> None:
        """Write (put and/or delete) multiple items in a single batch."""

    @abstractmethod
    async def create_table(self, config: TableConfig) -> dict:
        """Create a table dynamically. Returns a table description dict."""

    @abstractmethod
    async def delete_table(self, table_name: str) -> dict:
        """Delete a table. Returns a table description dict."""

    @abstractmethod
    async def describe_table(self, table_name: str) -> dict:
        """Return a table description dict."""

    @abstractmethod
    async def list_tables(self) -> list[str]:
        """Return a list of table names."""
