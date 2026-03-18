"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from lws.interfaces import (
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
        # Arrange
        expected_name = "pk"
        expected_type = "S"

        # Act
        attr = KeyAttribute(name=expected_name, type=expected_type)

        # Assert
        assert attr.name == expected_name
        assert attr.type == expected_type

    def test_key_schema_partition_only(self) -> None:
        # Arrange / Act
        schema = KeySchema(partition_key=KeyAttribute(name="pk", type="S"))

        # Assert
        assert schema.sort_key is None

    def test_key_schema_with_sort(self) -> None:
        # Arrange
        expected_sort_key_name = "sk"

        # Act
        schema = KeySchema(
            partition_key=KeyAttribute(name="pk", type="S"),
            sort_key=KeyAttribute(name=expected_sort_key_name, type="S"),
        )

        # Assert
        assert schema.sort_key is not None
        actual_sort_key_name = schema.sort_key.name
        assert actual_sort_key_name == expected_sort_key_name

    def test_gsi_definition_defaults(self) -> None:
        # Arrange
        expected_projection_type = "ALL"

        # Act
        gsi = GsiDefinition(
            index_name="gsi1",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="gsi1pk", type="S"),
            ),
        )

        # Assert
        actual_projection_type = gsi.projection_type
        assert actual_projection_type == expected_projection_type

    def test_table_config(self) -> None:
        # Arrange
        expected_table_name = "my-table"

        # Act
        cfg = TableConfig(
            table_name=expected_table_name,
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="pk", type="S"),
            ),
        )

        # Assert
        actual_table_name = cfg.table_name
        assert actual_table_name == expected_table_name
        assert cfg.gsi_definitions == []
