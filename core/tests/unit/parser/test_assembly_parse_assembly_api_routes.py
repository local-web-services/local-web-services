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


class TestParseAssemblyApiRoutes:
    def test_api_routes_collected(self, tmp_path: Path):
        # Arrange
        expected_method = "GET"
        expected_path = "/items"
        expected_handler_name = "MyFunc"
        cdk_out = tmp_path / "cdk.out"
        cdk_out.mkdir()

        tpl = {
            "Resources": {
                expected_handler_name: {
                    "Type": "AWS::Lambda::Function",
                    "Properties": {"Handler": "h", "Runtime": "python3.11"},
                },
                "ApiRes": {
                    "Type": "AWS::ApiGateway::Resource",
                    "Properties": {"PathPart": "items"},
                },
                "ApiMethod": {
                    "Type": "AWS::ApiGateway::Method",
                    "Properties": {
                        "HttpMethod": expected_method,
                        "ResourceId": "ApiRes",
                        "Integration": {
                            "Uri": {
                                "Fn::Sub": (
                                    "arn:aws:apigateway:${AWS::Region}"
                                    ":lambda:path/2015-03-31/functions/${MyFunc}/invocations"
                                )
                            }
                        },
                    },
                },
            },
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

        # Act
        model = parse_assembly(cdk_out)

        # Assert
        assert len(model.apis) == 1
        api = model.apis[0]
        assert len(api.routes) == 1
        actual_route = api.routes[0]
        assert actual_route.method == expected_method
        assert actual_route.path == expected_path
        assert actual_route.handler_name == expected_handler_name
