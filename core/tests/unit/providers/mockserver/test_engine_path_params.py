"""Unit tests for mock server route matching engine — path parameter extraction."""

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


class TestPathParams:
    def test_path_param_extraction(self):
        # Arrange
        route = _simple_route("/v1/users/{user_id}", "GET", body={"id": "{{path.user_id}}"})
        engine = RouteMatchEngine([route])
        expected_id = "usr_123"

        # Act
        result = engine.match(method="GET", path="/v1/users/usr_123")

        # Assert
        assert result is not None
        actual_id = result[0].body["id"]
        assert actual_id == expected_id

    def test_multiple_path_params(self):
        # Arrange
        route = _simple_route("/v1/{org}/users/{user_id}", "GET")
        engine = RouteMatchEngine([route])
        expected_org = "acme"
        expected_user_id = "u1"

        # Act
        result = engine.match(method="GET", path="/v1/acme/users/u1")

        # Assert
        assert result is not None
        path_params = result[1]
        actual_org = path_params["org"]
        actual_user_id = path_params["user_id"]
        assert actual_org == expected_org
        assert actual_user_id == expected_user_id
