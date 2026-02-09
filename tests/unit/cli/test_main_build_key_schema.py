"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _build_key_schema,
)


class TestBuildKeySchema:
    """Tests for _build_key_schema."""

    def test_hash_only(self):
        raw = [{"attribute_name": "pk", "type": "S", "key_type": "HASH"}]
        ks = _build_key_schema(raw)
        assert ks.partition_key.name == "pk"
        assert ks.partition_key.type == "S"
        assert ks.sort_key is None

    def test_hash_and_range(self):
        raw = [
            {"attribute_name": "pk", "type": "S", "key_type": "HASH"},
            {"attribute_name": "sk", "type": "S", "key_type": "RANGE"},
        ]
        ks = _build_key_schema(raw)
        assert ks.partition_key.name == "pk"
        assert ks.sort_key is not None
        assert ks.sort_key.name == "sk"

    def test_empty_defaults(self):
        ks = _build_key_schema([])
        assert ks.partition_key.name == "pk"
        assert ks.sort_key is None
