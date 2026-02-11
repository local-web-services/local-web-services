"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.template_parser import (
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
        # Arrange
        expected_method = "GET"
        expected_path = "/items"
        expected_uri = "arn:aws:lambda:..."
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
                    "HttpMethod": expected_method,
                    "ResourceId": "Res1",
                    "Integration": {"Uri": expected_uri},
                },
            ),
        ]

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == 1
        actual_method = routes[0].http_method
        actual_path = routes[0].resource_path
        actual_uri = routes[0].integration_uri
        assert actual_method == expected_method
        assert actual_path == expected_path
        assert actual_uri == expected_uri

    def test_http_api_v2_route(self):
        # Arrange
        expected_method = "POST"
        expected_path = "/users"
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

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == 1
        actual_method = routes[0].http_method
        actual_path = routes[0].resource_path
        assert actual_method == expected_method
        assert actual_path == expected_path

    def test_http_api_v2_route_resolves_integration_uri(self):
        """V2 route Target with Fn::Join should resolve to the integration's IntegrationUri."""
        # Arrange
        expected_method = "POST"
        expected_path = "/orders"
        expected_uri = {"Fn::GetAtt": ["CreateOrderFunction7F1C188E", "Arn"]}
        resources = [
            CfnResource(
                logical_id="MyIntegration",
                resource_type="AWS::ApiGatewayV2::Integration",
                properties={
                    "IntegrationUri": expected_uri,
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

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == 1
        actual_method = routes[0].http_method
        actual_path = routes[0].resource_path
        actual_uri = routes[0].integration_uri
        assert actual_method == expected_method
        assert actual_path == expected_path
        # Should resolve to the integration's IntegrationUri, not the route's Target
        assert actual_uri == expected_uri

    def test_http_api_v2_route_no_integration_resource_falls_back(self):
        """When the Ref in Target doesn't match an integration resource, use Target as-is."""
        # Arrange
        expected_uri = {
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
                    "Target": expected_uri,
                },
            ),
        ]

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == 1
        actual_uri = routes[0].integration_uri
        assert actual_uri == expected_uri

    def test_mixed_v1_and_v2(self):
        # Arrange
        expected_count = 2
        expected_methods = {"PUT", "DELETE"}
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

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == expected_count
        actual_methods = {r.http_method for r in routes}
        assert actual_methods == expected_methods

    def test_no_routes(self):
        resources = [
            CfnResource("Fn", "AWS::Lambda::Function", {}),
        ]
        assert extract_api_routes(resources) == []

    def test_method_without_matching_resource(self):
        # Arrange
        expected_path = "/"
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

        # Act
        routes = extract_api_routes(resources)

        # Assert
        assert len(routes) == 1
        # Falls back to "/" when resource not in path map
        actual_path = routes[0].resource_path
        assert actual_path == expected_path
