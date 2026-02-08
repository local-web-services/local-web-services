"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from ldk.cli.main import (
    _build_gsi,
)


class TestBuildGsi:
    """Tests for _build_gsi."""

    def test_basic_gsi(self):
        raw = {
            "index_name": "idx1",
            "key_schema": [{"attribute_name": "gsi_pk", "type": "S", "key_type": "HASH"}],
            "projection_type": "KEYS_ONLY",
        }
        gsi = _build_gsi(raw)
        assert gsi.index_name == "idx1"
        assert gsi.key_schema.partition_key.name == "gsi_pk"
        assert gsi.projection_type == "KEYS_ONLY"
