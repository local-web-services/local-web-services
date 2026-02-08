"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.template_parser import (
    CfnResource,
    extract_api_routes,
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


# ---------------------------------------------------------------------------
# extract_lambda_functions
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# extract_dynamo_tables
# ---------------------------------------------------------------------------


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

    def test_http_api_v2_route_resolves_integration_uri(self):
        """V2 route Target with Fn::Join should resolve to the integration's IntegrationUri."""
        resources = [
            CfnResource(
                logical_id="MyIntegration",
                resource_type="AWS::ApiGatewayV2::Integration",
                properties={
                    "IntegrationUri": {"Fn::GetAtt": ["CreateOrderFunction7F1C188E", "Arn"]},
                },
            ),
            CfnResource(
                logical_id="CreateOrderFunction7F1C188E",
                resource_type="AWS::Lambda::Function",
                properties={},
            ),
            CfnResource(
                logical_id="Route1",
                resource_type="AWS::ApiGatewayV2::Route",
                properties={
                    "RouteKey": "POST /orders",
                    "Target": {
                        "Fn::Join": [
                            "",
                            [
                                "integrations/",
                                {"Ref": "MyIntegration"},
                            ],
                        ]
                    },
                },
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 1
        assert routes[0].http_method == "POST"
        assert routes[0].resource_path == "/orders"
        # Should resolve to the integration's IntegrationUri, not the route's Target
        assert routes[0].integration_uri == {"Fn::GetAtt": ["CreateOrderFunction7F1C188E", "Arn"]}

    def test_http_api_v2_route_no_integration_resource_falls_back(self):
        """When the Ref in Target doesn't match an integration resource, use Target as-is."""
        target = {
            "Fn::Join": [
                "",
                [
                    "integrations/",
                    {"Ref": "NonExistentIntegration"},
                ],
            ]
        }
        resources = [
            CfnResource(
                logical_id="Route1",
                resource_type="AWS::ApiGatewayV2::Route",
                properties={
                    "RouteKey": "GET /fallback",
                    "Target": target,
                },
            ),
        ]
        routes = extract_api_routes(resources)
        assert len(routes) == 1
        assert routes[0].integration_uri == target

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
