"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.template_parser import (
    CfnResource,
    extract_api_routes,
    extract_dynamo_tables,
    extract_lambda_functions,
    parse_template,
)


@pytest.fixture()
def tmp_template(tmp_path: Path):
    """Write a CloudFormation template dict and return the path."""

    def _write(template: dict) -> Path:
        p = tmp_path / "template.json"
        p.write_text(json.dumps(template), encoding="utf-8")
        return p

    return _write


# ---------------------------------------------------------------------------
# parse_template
# ---------------------------------------------------------------------------


class TestParseTemplate:
    def test_extracts_resources(self, tmp_template):
        tpl = {
            "AWSTemplateFormatVersion": "2010-09-09",
            "Resources": {
                "MyFunc": {
                    "Type": "AWS::Lambda::Function",
                    "Properties": {"Handler": "index.handler", "Runtime": "python3.11"},
                },
                "MyTable": {
                    "Type": "AWS::DynamoDB::Table",
                    "Properties": {"TableName": "widgets"},
                },
            },
        }
        resources = parse_template(tmp_template(tpl))
        assert len(resources) == 2
        assert resources[0].logical_id == "MyFunc"
        assert resources[0].resource_type == "AWS::Lambda::Function"
        assert resources[1].logical_id == "MyTable"

    def test_empty_resources(self, tmp_template):
        tpl = {"Resources": {}}
        assert parse_template(tmp_template(tpl)) == []

    def test_missing_resources_key(self, tmp_template):
        tpl = {"AWSTemplateFormatVersion": "2010-09-09"}
        assert parse_template(tmp_template(tpl)) == []


# ---------------------------------------------------------------------------
# extract_lambda_functions
# ---------------------------------------------------------------------------


class TestExtractLambdaFunctions:
    def test_basic_lambda(self):
        resources = [
            CfnResource(
                logical_id="Fn1",
                resource_type="AWS::Lambda::Function",
                properties={
                    "Handler": "app.handler",
                    "Runtime": "nodejs18.x",
                    "Code": {"S3Bucket": "bucket", "S3Key": "abc123.zip"},
                    "Timeout": 60,
                    "MemorySize": 256,
                    "Environment": {"Variables": {"TABLE": "my-table"}},
                },
            ),
        ]
        result = extract_lambda_functions(resources)
        assert len(result) == 1
        lp = result[0]
        assert lp.handler == "app.handler"
        assert lp.runtime == "nodejs18.x"
        assert lp.timeout == 60
        assert lp.memory_size == 256
        assert lp.environment == {"TABLE": "my-table"}

    def test_lambda_without_environment(self):
        resources = [
            CfnResource(
                logical_id="Fn2",
                resource_type="AWS::Lambda::Function",
                properties={"Handler": "h", "Runtime": "python3.11"},
            ),
        ]
        result = extract_lambda_functions(resources)
        assert result[0].environment == {}

    def test_skips_non_lambda(self):
        resources = [
            CfnResource("T", "AWS::DynamoDB::Table", {}),
        ]
        assert extract_lambda_functions(resources) == []


# ---------------------------------------------------------------------------
# extract_dynamo_tables
# ---------------------------------------------------------------------------


class TestExtractDynamoTables:
    def test_basic_table(self):
        resources = [
            CfnResource(
                logical_id="Tbl",
                resource_type="AWS::DynamoDB::Table",
                properties={
                    "TableName": "orders",
                    "KeySchema": [
                        {"AttributeName": "pk", "KeyType": "HASH"},
                    ],
                    "AttributeDefinitions": [
                        {"AttributeName": "pk", "AttributeType": "S"},
                    ],
                    "GlobalSecondaryIndexes": [
                        {
                            "IndexName": "gsi1",
                            "KeySchema": [
                                {"AttributeName": "pk", "KeyType": "HASH"},
                            ],
                        }
                    ],
                },
            ),
        ]
        result = extract_dynamo_tables(resources)
        assert len(result) == 1
        tp = result[0]
        assert tp.table_name == "orders"
        assert len(tp.key_schema) == 1
        assert len(tp.gsi_definitions) == 1

    def test_table_without_gsi(self):
        resources = [
            CfnResource(
                logical_id="T",
                resource_type="AWS::DynamoDB::Table",
                properties={
                    "KeySchema": [{"AttributeName": "id", "KeyType": "HASH"}],
                    "AttributeDefinitions": [
                        {"AttributeName": "id", "AttributeType": "S"},
                    ],
                },
            ),
        ]
        result = extract_dynamo_tables(resources)
        assert result[0].gsi_definitions == []


# ---------------------------------------------------------------------------
# extract_api_routes
# ---------------------------------------------------------------------------


class TestExtractApiRoutes:
    def test_rest_api_v1_method(self):
        resources = [
            CfnResource(
                logical_id="Res1",
                resource_type="AWS::ApiGateway::Resource",
                properties={"PathPart": "items"},
            ),
            CfnResource(
                logical_id="Method1",
                resource_type="AWS::ApiGateway::Method",
                properties={
                    "HttpMethod": "GET",
                    "ResourceId": "Res1",
                    "Integration": {"Uri": "arn:aws:lambda:..."},
                },
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 1
        assert routes[0].http_method == "GET"
        assert routes[0].resource_path == "/items"
        assert routes[0].integration_uri == "arn:aws:lambda:..."

    def test_http_api_v2_route(self):
        resources = [
            CfnResource(
                logical_id="Route1",
                resource_type="AWS::ApiGatewayV2::Route",
                properties={
                    "RouteKey": "POST /users",
                    "Target": "integrations/abc123",
                },
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 1
        assert routes[0].http_method == "POST"
        assert routes[0].resource_path == "/users"

    def test_mixed_v1_and_v2(self):
        resources = [
            CfnResource(
                "Res",
                "AWS::ApiGateway::Resource",
                {"PathPart": "orders"},
            ),
            CfnResource(
                "M",
                "AWS::ApiGateway::Method",
                {
                    "HttpMethod": "PUT",
                    "ResourceId": "Res",
                    "Integration": {"Uri": "uri1"},
                },
            ),
            CfnResource(
                "R2",
                "AWS::ApiGatewayV2::Route",
                {"RouteKey": "DELETE /orders/{id}"},
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 2
        methods = {r.http_method for r in routes}
        assert methods == {"PUT", "DELETE"}

    def test_no_routes(self):
        resources = [
            CfnResource("Fn", "AWS::Lambda::Function", {}),
        ]
        assert extract_api_routes(resources) == []

    def test_method_without_matching_resource(self):
        resources = [
            CfnResource(
                "M",
                "AWS::ApiGateway::Method",
                {
                    "HttpMethod": "GET",
                    "ResourceId": "NonExistent",
                    "Integration": {},
                },
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 1
        # Falls back to "/" when resource not in path map
        assert routes[0].resource_path == "/"
