"""Tests for ldk.parser.assembly (assembly orchestrator)."""

from __future__ import annotations

import json
from pathlib import Path

from ldk.parser.assembly import (
    AppModel,
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


class TestEdgeCases:
    def test_no_manifest(self, tmp_path: Path):
        model = parse_assembly(tmp_path)
        assert model == AppModel()

    def test_stack_with_missing_template(self, tmp_path: Path):
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()
        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "Bad": {
                    "type": "aws:cloudformation:stack",
                    "properties": {"templateFile": "nope.template.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)
        model = parse_assembly(cdk_out)
        assert model == AppModel()

    def test_lambda_with_no_code(self, tmp_path: Path):
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()
        tpl = {
            "Resources": {
                "Fn": {
                    "Type": "AWS::Lambda::Function",
                    "Properties": {"Handler": "h", "Runtime": "r"},
                }
            }
        }
        _write_json(cdk_out / "S.template.json", tpl)
        manifest = {
            "version": "21.0.0",
            "artifacts": {
                "S": {
                    "type": "aws:cloudformation:stack",
                    "properties": {"templateFile": "S.template.json"},
                }
            },
        }
        _write_json(cdk_out / "manifest.json", manifest)
        model = parse_assembly(cdk_out)
        assert len(model.functions) == 1
        assert model.functions[0].code_path is None
