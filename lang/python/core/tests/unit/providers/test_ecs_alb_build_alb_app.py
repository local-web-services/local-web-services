"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

import httpx
from fastapi.testclient import TestClient

from lws.providers.ecs.alb import (
    AlbConfig,
    ListenerRule,
    build_alb_app,
)

# ---------------------------------------------------------------------------
# Path matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Rule matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Listener rule parsing tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# _extract_path_pattern tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ALB FastAPI app tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ListenerRule tests
# ---------------------------------------------------------------------------


class TestBuildAlbApp:
    def test_catch_all_returns_404_no_rules(self) -> None:
        # Arrange
        config = AlbConfig(listener_rules=[], port=9000)
        app = build_alb_app(config)
        client = TestClient(app)

        # Act
        resp = client.get("/anything")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"

    @patch("httpx.AsyncClient.request")
    async def test_catch_all_proxies_matching_rule(self, fake_req: AsyncMock) -> None:
        fake_resp = httpx.Response(
            200,
            content=b'{"ok": true}',
            headers={"content-type": "application/json"},
        )
        fake_req.return_value = fake_resp

        rules = [ListenerRule(priority=1, path_pattern="/api/*", target_port=8080)]
        config = AlbConfig(listener_rules=rules, port=9000)
        app = build_alb_app(config)

        from httpx import ASGITransport, AsyncClient

        async with AsyncClient(
            transport=ASGITransport(app=app),
            base_url="http://testserver",
        ) as client:
            resp = await client.get("/api/users")

        expected_status = 200
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"

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
        assert "/health" in route_paths, f'Expected {"/health"!r} to be in {route_paths!r}'
