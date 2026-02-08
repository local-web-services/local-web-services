"""Tests for ldk.parser.asset_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.asset_parser import parse_assets


@pytest.fixture()
def cdk_out(tmp_path: Path) -> Path:
    """Return a tmp ``cdk.out`` directory."""
    return tmp_path


def _write_json(path: Path, data: dict) -> None:
    path.write_text(json.dumps(data), encoding="utf-8")


class TestParseAssetsFromAssetManifest:
    """Assets located via a dedicated ``*.assets.json`` manifest."""

    def test_single_file_asset(self, cdk_out: Path):
        # Create the asset directory
        asset_dir = cdk_out / "asset.abc123"
        asset_dir.mkdir()
        (asset_dir / "index.py").write_text("print('hi')")

        # Asset manifest
        asset_manifest = {
            "version": "21.0.0",
            "files": {
                "abc123": {
                    "source": {"path": "asset.abc123", "packaging": "zip"},
                    "destinations": {},
                }
            },
        }
        _write_json(cdk_out / "MyStack.assets.json", asset_manifest)

        # Main manifest referencing the asset manifest
        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "MyStack.assets": {
                    "type": "aws:cdk:asset-manifest",
                    "properties": {"file": "MyStack.assets.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)

        result = parse_assets(cdk_out)
        assert "abc123" in result
        assert result["abc123"] == (cdk_out / "asset.abc123").resolve()

    def test_multiple_file_assets(self, cdk_out: Path):
        for h in ("hash1", "hash2"):
            d = cdk_out / f"asset.{h}"
            d.mkdir()

        asset_manifest = {
            "version": "21.0.0",
            "files": {
                "hash1": {"source": {"path": "asset.hash1"}, "destinations": {}},
                "hash2": {"source": {"path": "asset.hash2"}, "destinations": {}},
            },
        }
        _write_json(cdk_out / "Stack.assets.json", asset_manifest)

        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "Stack.assets": {
                    "type": "aws:cdk:asset-manifest",
                    "properties": {"file": "Stack.assets.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)

        result = parse_assets(cdk_out)
        assert len(result) == 2
        assert "hash1" in result
        assert "hash2" in result

    def test_docker_image_asset(self, cdk_out: Path):
        img_dir = cdk_out / "asset.docker1"
        img_dir.mkdir()

        asset_manifest = {
            "version": "21.0.0",
            "files": {},
            "dockerImages": {
                "docker1": {
                    "source": {"directory": "asset.docker1"},
                    "destinations": {},
                }
            },
        }
        _write_json(cdk_out / "S.assets.json", asset_manifest)
        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "S.assets": {
                    "type": "aws:cdk:asset-manifest",
                    "properties": {"file": "S.assets.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)

        result = parse_assets(cdk_out)
        assert "docker1" in result


class TestParseAssetsFromMetadata:
    """Assets discovered via inline ``aws:cdk:asset`` metadata."""

    def test_metadata_asset(self, cdk_out: Path):
        asset_dir = cdk_out / "asset.meta1"
        asset_dir.mkdir()

        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "MyStack": {
                    "type": "aws:cloudformation:stack",
                    "metadata": {
                        "/MyStack/Func/Resource": [
                            {
                                "type": "aws:cdk:asset",
                                "data": {
                                    "sourceHash": "meta1",
                                    "path": "asset.meta1",
                                },
                            }
                        ]
                    },
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)

        result = parse_assets(cdk_out)
        assert "meta1" in result


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
