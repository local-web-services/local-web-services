"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _build_key_schema,
)


class TestBuildKeySchema:
    """Tests for _build_key_schema."""

    def test_hash_only(self):
        # Arrange
        expected_name = "pk"
        expected_type = "S"
        raw = [{"attribute_name": expected_name, "type": expected_type, "key_type": "HASH"}]

        # Act
        ks = _build_key_schema(raw)

        # Assert
        assert ks.partition_key.name == expected_name
        assert ks.partition_key.type == expected_type
        assert ks.sort_key is None

    def test_hash_and_range(self):
        # Arrange
        expected_partition_key_name = "pk"
        expected_sort_key_name = "sk"
        raw = [
            {"attribute_name": expected_partition_key_name, "type": "S", "key_type": "HASH"},
            {"attribute_name": expected_sort_key_name, "type": "S", "key_type": "RANGE"},
        ]

        # Act
        ks = _build_key_schema(raw)

        # Assert
        assert ks.partition_key.name == expected_partition_key_name
        assert ks.sort_key is not None
        assert ks.sort_key.name == expected_sort_key_name

    def test_empty_defaults(self):
        # Arrange
        expected_default_name = "pk"

        # Act
        ks = _build_key_schema([])

        # Assert
        assert ks.partition_key.name == expected_default_name
        assert ks.sort_key is None
