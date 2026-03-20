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
        assert (
            ks.partition_key.name == expected_name
        ), f"Expected {expected_name!r} but got {ks.partition_key.name!r}"
        assert (
            ks.partition_key.type == expected_type
        ), f"Expected {expected_type!r} but got {ks.partition_key.type!r}"
        assert ks.sort_key is None, f"Expected None but got {ks.sort_key!r}"

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
        assert (
            ks.partition_key.name == expected_partition_key_name
        ), f"Expected {expected_partition_key_name!r} but got {ks.partition_key.name!r}"
        assert ks.sort_key is not None, "Expected value to be set but was None"
        assert (
            ks.sort_key.name == expected_sort_key_name
        ), f"Expected {expected_sort_key_name!r} but got {ks.sort_key.name!r}"

    def test_empty_defaults(self):
        # Arrange
        expected_default_name = "pk"

        # Act
        ks = _build_key_schema([])

        # Assert
        assert (
            ks.partition_key.name == expected_default_name
        ), f"Expected {expected_default_name!r} but got {ks.partition_key.name!r}"
        assert ks.sort_key is None, f"Expected None but got {ks.sort_key!r}"
