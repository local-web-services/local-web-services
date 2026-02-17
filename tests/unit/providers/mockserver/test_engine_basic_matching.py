"""Unit tests for mock server route matching engine — basic route matching."""

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


class TestBasicRouteMatching:
    def test_exact_path_match(self):
        # Arrange
        route = _simple_route("/v1/health", "GET", body={"status": "ok"})
        engine = RouteMatchEngine([route])
        expected_status = 200

        # Act
        result = engine.match(method="GET", path="/v1/health")

        # Assert
        assert result is not None
        actual_status = result[0].status
        assert actual_status == expected_status

    def test_no_match_wrong_path(self):
        # Arrange
        route = _simple_route("/v1/health", "GET")
        engine = RouteMatchEngine([route])

        # Act
        result = engine.match(method="GET", path="/v1/other")

        # Assert
        assert result is None

    def test_no_match_wrong_method(self):
        # Arrange
        route = _simple_route("/v1/health", "GET")
        engine = RouteMatchEngine([route])

        # Act
        result = engine.match(method="POST", path="/v1/health")

        # Assert
        assert result is None
