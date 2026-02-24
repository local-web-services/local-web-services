"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _build_gsi,
)


class TestBuildGsi:
    """Tests for _build_gsi."""

    def test_basic_gsi(self):
        # Arrange
        expected_index_name = "idx1"
        expected_partition_key_name = "gsi_pk"
        expected_projection_type = "KEYS_ONLY"
        raw = {
            "index_name": expected_index_name,
            "key_schema": [
                {
                    "attribute_name": expected_partition_key_name,
                    "type": "S",
                    "key_type": "HASH",
                }
            ],
            "projection_type": expected_projection_type,
        }

        # Act
        gsi = _build_gsi(raw)

        # Assert
        assert gsi.index_name == expected_index_name
        assert gsi.key_schema.partition_key.name == expected_partition_key_name
        assert gsi.projection_type == expected_projection_type
