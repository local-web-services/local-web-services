"""Unit tests for fake server route matching engine — multiple route selection."""

from __future__ import annotations

from lws.providers.fakeserver.engine import RouteMatchEngine
from lws.providers.fakeserver.models import FakeResponse, MatchCriteria, RouteRule


def _simple_route(path: str, method: str, status: int = 200, body=None) -> RouteRule:
    """Helper to create a simple route with a catch-all response."""
    return RouteRule(
        path=path,
        method=method,
        responses=[(MatchCriteria(), FakeResponse(status=status, body=body))],
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
        assert result is not None, "Expected value to be set but was None"
        actual_type = result[0].body["type"]
        assert actual_type == expected_type, f"Expected {expected_type!r} but got {actual_type!r}"

    def test_second_route_matches(self):
        # Arrange
        route1 = _simple_route("/v1/users", "GET", body={"type": "list"})
        route2 = _simple_route("/v1/users/{id}", "GET", body={"type": "detail"})
        engine = RouteMatchEngine([route1, route2])
        expected_type = "detail"

        # Act
        result = engine.match(method="GET", path="/v1/users/123")

        # Assert
        assert result is not None, "Expected value to be set but was None"
        actual_type = result[0].body["type"]
        assert actual_type == expected_type, f"Expected {expected_type!r} but got {actual_type!r}"
