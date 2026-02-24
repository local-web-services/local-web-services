"""Unit tests for mock server route matching engine — multiple route selection."""

from __future__ import annotations

from lws.providers.mockserver.engine import RouteMatchEngine
from lws.providers.mockserver.models import MatchCriteria, MockResponse, RouteRule


def _simple_route(path: str, method: str, status: int = 200, body=None) -> RouteRule:
    """Helper to create a simple route with a catch-all response."""
    return RouteRule(
        path=path,
        method=method,
        responses=[(MatchCriteria(), MockResponse(status=status, body=body))],
    )


class TestMultipleRoutes:
    def test_first_matching_route(self):
        # Arrange
        route1 = _simple_route("/v1/users", "GET", body={"type": "list"})
        route2 = _simple_route("/v1/users/{id}", "GET", body={"type": "detail"})
        engine = RouteMatchEngine([route1, route2])
        expected_type = "list"

        # Act
        result = engine.match(method="GET", path="/v1/users")

        # Assert
        assert result is not None
        actual_type = result[0].body["type"]
        assert actual_type == expected_type

    def test_second_route_matches(self):
        # Arrange
        route1 = _simple_route("/v1/users", "GET", body={"type": "list"})
        route2 = _simple_route("/v1/users/{id}", "GET", body={"type": "detail"})
        engine = RouteMatchEngine([route1, route2])
        expected_type = "detail"

        # Act
        result = engine.match(method="GET", path="/v1/users/123")

        # Assert
        assert result is not None
        actual_type = result[0].body["type"]
        assert actual_type == expected_type
