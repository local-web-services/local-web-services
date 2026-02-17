"""Unit tests for match_graphql_request in GraphQL handler."""

from __future__ import annotations

from lws.providers.mockserver.graphql_handler import match_graphql_request
from lws.providers.mockserver.models import GraphQLRoute


class TestMatchGraphqlRequest:
    def test_catch_all_match(self):
        # Arrange
        route = GraphQLRoute(
            operation="Query.user",
            match={},
            response={"data": {"user": {"id": "1", "name": "Test"}}},
        )
        body = {"query": "query GetUser { user { id name } }", "variables": {}}

        # Act
        result = match_graphql_request([route], body)

        # Assert
        assert result is not None
        expected_name = "Test"
        actual_name = result["data"]["user"]["name"]
        assert actual_name == expected_name

    def test_variable_match(self):
        # Arrange
        route_specific = GraphQLRoute(
            operation="Query.user",
            match={"variables": {"id": "user_notfound"}},
            response={"data": {"user": None}, "errors": [{"message": "Not found"}]},
        )
        route_default = GraphQLRoute(
            operation="Query.user",
            match={},
            response={"data": {"user": {"id": "1"}}},
        )
        body = {
            "query": "query GetUser { user { id } }",
            "variables": {"id": "user_notfound"},
        }

        # Act
        result = match_graphql_request([route_specific, route_default], body)

        # Assert
        assert result is not None
        assert result["data"]["user"] is None

    def test_no_match(self):
        # Arrange
        route = GraphQLRoute(
            operation="Query.order",
            match={},
            response={"data": {"order": {}}},
        )
        body = {"query": "query GetUser { user { id } }", "variables": {}}

        # Act
        result = match_graphql_request([route], body)

        # Assert
        assert result is None

    def test_template_rendering_in_response(self):
        # Arrange
        route = GraphQLRoute(
            operation="Query.user",
            match={},
            response={"data": {"user": {"id": "{{variables.id}}"}}},
        )
        body = {
            "query": "query GetUser { user { id } }",
            "variables": {"id": "usr_42"},
        }

        # Act
        result = match_graphql_request([route], body)

        # Assert
        expected_id = "usr_42"
        actual_id = result["data"]["user"]["id"]
        assert actual_id == expected_id
