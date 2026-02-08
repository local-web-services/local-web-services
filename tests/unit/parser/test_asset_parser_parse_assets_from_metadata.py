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
