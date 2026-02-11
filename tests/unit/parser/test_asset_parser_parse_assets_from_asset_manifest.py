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


class TestParseAssetsFromAssetManifest:
    """Assets located via a dedicated ``*.assets.json`` manifest."""

    def test_single_file_asset(self, cdk_out: Path):
        # Arrange
        asset_hash = "abc123"
        asset_dir = cdk_out / f"asset.{asset_hash}"
        asset_dir.mkdir()
        (asset_dir / "index.py").write_text("print('hi')")

        asset_manifest = {
            "version": "21.0.0",
            "files": {
                asset_hash: {
                    "source": {"path": f"asset.{asset_hash}", "packaging": "zip"},
                    "destinations": {},
                }
            },
        }
        _write_json(cdk_out / "MyStack.assets.json", asset_manifest)

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
        expected_path = (cdk_out / f"asset.{asset_hash}").resolve()

        # Act
        result = parse_assets(cdk_out)

        # Assert
        assert asset_hash in result
        actual_path = result[asset_hash]
        assert actual_path == expected_path

    def test_multiple_file_assets(self, cdk_out: Path):
        # Arrange
        expected_count = 2
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

        # Act
        result = parse_assets(cdk_out)

        # Assert
        assert len(result) == expected_count
        assert "hash1" in result
        assert "hash2" in result

    def test_docker_image_asset(self, cdk_out: Path):
        # Arrange
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

        # Act
        result = parse_assets(cdk_out)

        # Assert
        assert "docker1" in result

    def test_cdk_asset_manifest_type(self, cdk_out: Path):
        """Modern CDK emits ``cdk:asset-manifest`` instead of ``aws:cdk:asset-manifest``."""
        # Arrange
        asset_hash = "modern1"
        asset_dir = cdk_out / f"asset.{asset_hash}"
        asset_dir.mkdir()
        (asset_dir / "index.js").write_text("exports.handler = () => {}")

        asset_manifest = {
            "version": "36.0.0",
            "files": {
                asset_hash: {
                    "source": {"path": f"asset.{asset_hash}", "packaging": "zip"},
                    "destinations": {},
                }
            },
        }
        _write_json(cdk_out / "MyStack.assets.json", asset_manifest)

        manifest = {
            "version": "36.0.0",
            "artifacts": {
                "MyStack.assets": {
                    "type": "cdk:asset-manifest",
                    "properties": {"file": "MyStack.assets.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)
        expected_path = (cdk_out / f"asset.{asset_hash}").resolve()

        # Act
        result = parse_assets(cdk_out)

        # Assert
        assert asset_hash in result
        actual_path = result[asset_hash]
        assert actual_path == expected_path
