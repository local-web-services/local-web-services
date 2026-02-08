"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from ldk.interfaces import (
    GsiDefinition,
    KeyAttribute,
    KeySchema,
    TableConfig,
)

# ---------------------------------------------------------------------------
# P0-07: Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-08: ICompute
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-09: IKeyValueStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-10: Remaining provider interfaces
# ---------------------------------------------------------------------------


class TestKeyValueStoreDataclasses:
    """Key-value store supporting dataclasses."""

    def test_key_attribute(self) -> None:
        attr = KeyAttribute(name="pk", type="S")
        assert attr.name == "pk"
        assert attr.type == "S"

    def test_key_schema_partition_only(self) -> None:
        schema = KeySchema(partition_key=KeyAttribute(name="pk", type="S"))
        assert schema.sort_key is None

    def test_key_schema_with_sort(self) -> None:
        schema = KeySchema(
            partition_key=KeyAttribute(name="pk", type="S"),
            sort_key=KeyAttribute(name="sk", type="S"),
        )
        assert schema.sort_key is not None
        assert schema.sort_key.name == "sk"

    def test_gsi_definition_defaults(self) -> None:
        gsi = GsiDefinition(
            index_name="gsi1",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="gsi1pk", type="S"),
            ),
        )
        assert gsi.projection_type == "ALL"

    def test_table_config(self) -> None:
        cfg = TableConfig(
            table_name="my-table",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="pk", type="S"),
            ),
        )
        assert cfg.table_name == "my-table"
        assert cfg.gsi_definitions == []
