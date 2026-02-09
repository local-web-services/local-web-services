"""Tests for ldk.parser.asset_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.asset_parser import parse_assets


@pytest.fixture()
def cdk_out(tmp_path: Path) -> Path:
    """Return a tmp ``cdk.out`` directory."""
    return tmp_path


def _write_json(path: Path, data: dict) -> None:
    path.write_text(json.dumps(data), encoding="utf-8")


class TestEdgeCases:
    def test_no_manifest(self, cdk_out: Path):
        result = parse_assets(cdk_out)
        assert result == {}

    def test_empty_artifacts(self, cdk_out: Path):
        _write_json(cdk_out / "manifest.json", {"version": "21.0.0", "artifacts": {}})
        result = parse_assets(cdk_out)
        assert result == {}

    def test_missing_asset_manifest_file(self, cdk_out: Path, caplog):
        """Asset manifest referenced but file doesn't exist."""
        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "X.assets": {
                    "type": "aws:cdk:asset-manifest",
                    "properties": {"file": "nonexistent.assets.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)
        import logging

        with caplog.at_level(logging.WARNING):
            result = parse_assets(cdk_out)
        assert result == {}
