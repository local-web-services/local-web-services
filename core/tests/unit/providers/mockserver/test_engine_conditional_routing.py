"""Unit tests for mock server route matching engine — conditional routing."""

from __future__ import annotations

from lws.providers.mockserver.engine import RouteMatchEngine
from lws.providers.mockserver.models import MatchCriteria, MockResponse, RouteRule


class TestConditionalRouting:
    def test_header_match(self):
        # Arrange
        criteria_v2 = MatchCriteria(headers={"X-Api-Version": "2"})
        resp_v2 = MockResponse(status=200, body={"version": 2})

        criteria_default = MatchCriteria()
        resp_default = MockResponse(status=200, body={"version": 1})

        route = RouteRule(
            path="/v1/data",
            method="GET",
            responses=[(criteria_v2, resp_v2), (criteria_default, resp_default)],
        )
        engine = RouteMatchEngine([route])
        expected_version = 2

        # Act
        result = engine.match(method="GET", path="/v1/data", headers={"X-Api-Version": "2"})

        # Assert
        assert result is not None
        actual_version = result[0].body["version"]
        assert actual_version == expected_version

    def test_header_no_match_falls_through(self):
        # Arrange
        criteria_v2 = MatchCriteria(headers={"X-Api-Version": "2"})
        resp_v2 = MockResponse(status=200, body={"version": 2})

        criteria_default = MatchCriteria()
        resp_default = MockResponse(status=200, body={"version": 1})

        route = RouteRule(
            path="/v1/data",
            method="GET",
            responses=[(criteria_v2, resp_v2), (criteria_default, resp_default)],
        )
        engine = RouteMatchEngine([route])
        expected_version = 1

        # Act
        result = engine.match(method="GET", path="/v1/data", headers={"X-Api-Version": "1"})

        # Assert
        assert result is not None
        actual_version = result[0].body["version"]
        assert actual_version == expected_version

    def test_path_param_regex_match(self):
        # Arrange
        criteria = MatchCriteria(path_params={"id": r"pay_expired_.*"})
        resp = MockResponse(status=410, body={"error": "expired"})

        criteria_default = MatchCriteria()
        resp_default = MockResponse(status=200, body={"status": "ok"})

        route = RouteRule(
            path="/v1/payments/{id}",
            method="GET",
            responses=[(criteria, resp), (criteria_default, resp_default)],
        )
        engine = RouteMatchEngine([route])
        expected_status = 410

        # Act
        result = engine.match(method="GET", path="/v1/payments/pay_expired_abc")

        # Assert
        assert result is not None
        actual_status = result[0].status
        assert actual_status == expected_status

    def test_query_param_match(self):
        # Arrange
        criteria = MatchCriteria(query_params={"status": "active"})
        resp = MockResponse(status=200, body={"filter": "active"})

        criteria_default = MatchCriteria()
        resp_default = MockResponse(status=200, body={"filter": "all"})

        route = RouteRule(
            path="/v1/items",
            method="GET",
            responses=[(criteria, resp), (criteria_default, resp_default)],
        )
        engine = RouteMatchEngine([route])
        expected_filter = "active"

        # Act
        result = engine.match(method="GET", path="/v1/items", query_params={"status": "active"})

        # Assert
        assert result is not None
        actual_filter = result[0].body["filter"]
        assert actual_filter == expected_filter

    def test_body_matcher(self):
        # Arrange
        criteria = MatchCriteria(body_matchers={"amount": {"$gt": 1000}})
        resp = MockResponse(status=200, body={"tier": "premium"})

        criteria_default = MatchCriteria()
        resp_default = MockResponse(status=200, body={"tier": "standard"})

        route = RouteRule(
            path="/v1/check",
            method="POST",
            responses=[(criteria, resp), (criteria_default, resp_default)],
        )
        engine = RouteMatchEngine([route])
        expected_tier = "premium"

        # Act
        result = engine.match(method="POST", path="/v1/check", body={"amount": 5000})

        # Assert
        assert result is not None
        actual_tier = result[0].body["tier"]
        assert actual_tier == expected_tier
