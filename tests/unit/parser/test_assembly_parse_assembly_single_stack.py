"""Tests for ldk.parser.assembly (assembly orchestrator)."""

from __future__ import annotations

import json
from pathlib import Path

from lws.parser.assembly import (
    parse_assembly,
)


def _write_json(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data), encoding="utf-8")


def _make_simple_cdk_out(cdk_out: Path) -> None:
    """Scaffold a minimal cdk.out with one stack, one Lambda, one table."""
    # Asset
    asset_dir = cdk_out / "asset.abc123"
    asset_dir.mkdir(parents=True, exist_ok=True)
    (asset_dir / "index.py").write_text("def handler(event, ctx): pass")

    # Template
    template = {
        "AWSTemplateFormatVersion": "2010-09-09",
        "Resources": {
            "MyFunc": {
                "Type": "AWS::Lambda::Function",
                "Properties": {
                    "Handler": "index.handler",
                    "Runtime": "python3.11",
                    "Code": {"S3Bucket": "cdk-bucket", "S3Key": "abc123.zip"},
                    "Timeout": 30,
                    "MemorySize": 256,
                    "Environment": {"Variables": {"TABLE_NAME": "orders"}},
                },
            },
            "MyTable": {
                "Type": "AWS::DynamoDB::Table",
                "Properties": {
                    "TableName": "orders",
                    "KeySchema": [{"AttributeName": "pk", "KeyType": "HASH"}],
                    "AttributeDefinitions": [{"AttributeName": "pk", "AttributeType": "S"}],
                },
            },
        },
    }
    _write_json(cdk_out / "MyStack.template.json", template)

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

    # Tree
    tree = {
        "version": "tree-0.1",
        "tree": {
            "id": "App",
            "path": "",
            "children": {
                "MyStack": {
                    "id": "MyStack",
                    "path": "MyStack",
                    "constructInfo": {"fqn": "aws-cdk-lib.Stack"},
                }
            },
        },
    }
    _write_json(cdk_out / "tree.json", tree)

    # Main manifest
    manifest = {
        "version": "21.0.0",
        "artifacts": {
            "MyStack.assets": {
                "type": "aws:cdk:asset-manifest",
                "properties": {"file": "MyStack.assets.json"},
            },
            "MyStack": {
                "type": "aws:cloudformation:stack",
                "properties": {"templateFile": "MyStack.template.json"},
            },
        },
    }
    _write_json(cdk_out / "manifest.json", manifest)


class TestParseAssemblySingleStack:
    def test_extracts_lambda(self, tmp_path: Path):
        # Arrange
        expected_name = "MyFunc"
        expected_handler = "index.handler"
        expected_runtime = "python3.11"
        expected_timeout = 30
        expected_memory = 256
        expected_table_env = "orders"
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()
        _make_simple_cdk_out(cdk_out)

        # Act
        model = parse_assembly(cdk_out)

        # Assert
        assert len(model.functions) == 1
        actual_fn = model.functions[0]
        assert actual_fn.name == expected_name
        assert actual_fn.handler == expected_handler
        assert actual_fn.runtime == expected_runtime
        assert actual_fn.timeout == expected_timeout
        assert actual_fn.memory == expected_memory
        assert actual_fn.environment["TABLE_NAME"] == expected_table_env

    def test_extracts_table(self, tmp_path: Path):
        # Arrange
        expected_name = "orders"
        expected_key_schema_count = 1
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()
        _make_simple_cdk_out(cdk_out)

        # Act
        model = parse_assembly(cdk_out)

        # Assert
        assert len(model.tables) == 1
        actual_tbl = model.tables[0]
        assert actual_tbl.name == expected_name
        assert len(actual_tbl.key_schema) == expected_key_schema_count

    def test_resolves_asset_path(self, tmp_path: Path):
        # Arrange
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()
        _make_simple_cdk_out(cdk_out)

        # Act
        model = parse_assembly(cdk_out)

        # Assert
        actual_fn = model.functions[0]
        assert actual_fn.code_path is not None
        assert actual_fn.code_path.exists()
