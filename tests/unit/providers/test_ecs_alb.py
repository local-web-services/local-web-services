"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

import httpx
from fastapi.testclient import TestClient

from ldk.providers.ecs.alb import (
    AlbConfig,
    ListenerRule,
    _extract_path_pattern,
    _find_matching_rule,
    _path_matches,
    build_alb_app,
    parse_listener_rules,
)

# ---------------------------------------------------------------------------
# Path matching tests
# ---------------------------------------------------------------------------


class TestPathMatches:
    def test_wildcard_matches_everything(self) -> None:
        assert _path_matches("*", "/anything") is True

    def test_slash_wildcard_matches_everything(self) -> None:
        assert _path_matches("/*", "/anything") is True

    def test_prefix_wildcard(self) -> None:
        assert _path_matches("/api/*", "/api/users") is True
        assert _path_matches("/api/*", "/other/path") is False

    def test_suffix_wildcard(self) -> None:
        assert _path_matches("*.html", "/page.html") is True
        assert _path_matches("*.html", "/page.json") is False

    def test_exact_match(self) -> None:
        assert _path_matches("/health", "/health") is True
        assert _path_matches("/health", "/healthz") is False


# ---------------------------------------------------------------------------
# Rule matching tests
# ---------------------------------------------------------------------------


class TestFindMatchingRule:
    def test_returns_highest_priority_match(self) -> None:
        rules = [
            ListenerRule(priority=200, path_pattern="/api/*", target_port=8080),
            ListenerRule(priority=100, path_pattern="/api/*", target_port=9090),
        ]
        result = _find_matching_rule(rules, "/api/users")
        assert result is not None
        assert result.target_port == 9090

    def test_returns_none_when_no_match(self) -> None:
        rules = [ListenerRule(priority=1, path_pattern="/api/*", target_port=8080)]
        result = _find_matching_rule(rules, "/other")
        assert result is None

    def test_empty_rules_returns_none(self) -> None:
        assert _find_matching_rule([], "/path") is None


# ---------------------------------------------------------------------------
# Listener rule parsing tests
# ---------------------------------------------------------------------------


class TestParseListenerRules:
    def test_parse_path_pattern_field(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 10,
                    "Conditions": [
                        {"Field": "path-pattern", "Values": ["/api/*"]},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert len(rules) == 1
        assert rules[0].priority == 10
        assert rules[0].path_pattern == "/api/*"

    def test_parse_path_pattern_config(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 20,
                    "Conditions": [
                        {"PathPatternConfig": {"Values": ["/web/*"]}},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert len(rules) == 1
        assert rules[0].path_pattern == "/web/*"

    def test_skip_non_listener_rules(self) -> None:
        resources = {
            "Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {},
            }
        }
        rules = parse_listener_rules(resources)
        assert rules == []

    def test_skip_rules_without_path_condition(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 10,
                    "Conditions": [
                        {"Field": "host-header", "Values": ["example.com"]},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert rules == []


# ---------------------------------------------------------------------------
# _extract_path_pattern tests
# ---------------------------------------------------------------------------


class TestExtractPathPattern:
    def test_field_based(self) -> None:
        conditions = [{"Field": "path-pattern", "Values": ["/api/*"]}]
        assert _extract_path_pattern(conditions) == "/api/*"

    def test_config_based(self) -> None:
        conditions = [{"PathPatternConfig": {"Values": ["/web/*"]}}]
        assert _extract_path_pattern(conditions) == "/web/*"

    def test_empty_conditions(self) -> None:
        assert _extract_path_pattern([]) is None

    def test_no_matching_field(self) -> None:
        conditions = [{"Field": "host-header", "Values": ["example.com"]}]
        assert _extract_path_pattern(conditions) is None


# ---------------------------------------------------------------------------
# ALB FastAPI app tests
# ---------------------------------------------------------------------------


class TestBuildAlbApp:
    def test_catch_all_returns_404_no_rules(self) -> None:
        config = AlbConfig(listener_rules=[], port=9000)
        app = build_alb_app(config)
        client = TestClient(app)
        resp = client.get("/anything")
        assert resp.status_code == 404

    @patch("httpx.AsyncClient.request")
    async def test_catch_all_proxies_matching_rule(self, mock_req: AsyncMock) -> None:
        mock_resp = httpx.Response(
            200,
            content=b'{"ok": true}',
            headers={"content-type": "application/json"},
        )
        mock_req.return_value = mock_resp

        rules = [ListenerRule(priority=1, path_pattern="/api/*", target_port=8080)]
        config = AlbConfig(listener_rules=rules, port=9000)
        app = build_alb_app(config)

        from httpx import ASGITransport, AsyncClient

        async with AsyncClient(
            transport=ASGITransport(app=app),
            base_url="http://testserver",
        ) as client:
            resp = await client.get("/api/users")

        assert resp.status_code == 200

    def test_health_check_route_registered(self) -> None:
        rules = [
            ListenerRule(
                priority=1,
                path_pattern="/api/*",
                target_port=8080,
                health_check_path="/health",
            )
        ]
        config = AlbConfig(listener_rules=rules, port=9000)
        app = build_alb_app(config)

        route_paths = [r.path for r in app.routes if hasattr(r, "path")]
        assert "/health" in route_paths


# ---------------------------------------------------------------------------
# ListenerRule tests
# ---------------------------------------------------------------------------


class TestListenerRule:
    def test_defaults(self) -> None:
        rule = ListenerRule(priority=1, path_pattern="/api/*")
        assert rule.target_host == "localhost"
        assert rule.target_port == 8080
        assert rule.health_check_path is None
