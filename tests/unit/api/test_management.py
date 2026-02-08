"""Unit tests for the LDK management API."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from ldk.api.management import create_management_router
from ldk.interfaces import ICompute, InvocationResult, LambdaContext
from ldk.interfaces.provider import Provider
from ldk.runtime.orchestrator import Orchestrator


class FakeCompute(ICompute):
    """Fake compute provider for testing."""

    def __init__(self, name: str = "test-func", result: dict | None = None) -> None:
        self._name = name
        self._result = result or {"statusCode": 200, "body": "ok"}

    @property
    def name(self) -> str:
        return f"lambda:{self._name}"

    async def start(self) -> None:
        pass

    async def stop(self) -> None:
        pass

    async def health_check(self) -> bool:
        return True

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        return InvocationResult(
            payload=self._result, error=None, duration_ms=1.0, request_id="test-req-id"
        )


class FakeProvider(Provider):
    """Fake provider for testing."""

    def __init__(self, provider_name: str = "fake", healthy: bool = True) -> None:
        self._name = provider_name
        self._healthy = healthy
        self._started = False

    @property
    def name(self) -> str:
        return self._name

    async def start(self) -> None:
        self._started = True

    async def stop(self) -> None:
        self._started = False

    async def health_check(self) -> bool:
        return self._healthy


class ErrorCompute(ICompute):
    """Compute provider that always errors."""

    @property
    def name(self) -> str:
        return "lambda:error-func"

    async def start(self) -> None:
        pass

    async def stop(self) -> None:
        pass

    async def health_check(self) -> bool:
        return True

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        return InvocationResult(
            payload=None, error="handler error", duration_ms=0.5, request_id="err-req-id"
        )


@pytest.fixture
def management_app():
    """Create a FastAPI app with the management router."""
    orchestrator = Orchestrator()
    orchestrator._running = True

    compute_providers = {
        "myFunc": FakeCompute("myFunc", {"statusCode": 200, "body": '{"id": 1}'}),
        "errorFunc": ErrorCompute(),
    }

    providers = {
        "lambda:myFunc": FakeProvider("lambda:myFunc"),
        "dynamodb": FakeProvider("dynamodb"),
    }
    orchestrator._providers = providers

    router = create_management_router(
        orchestrator=orchestrator,
        compute_providers=compute_providers,
        providers=providers,
    )

    app = FastAPI()
    app.include_router(router)
    return app


@pytest.fixture
def client(management_app):
    """Create a test client for the management API."""
    return TestClient(management_app)


class TestStatusEndpoint:
    """Tests for GET /_ldk/status."""

    def test_status_returns_running(self, client):
        resp = client.get("/_ldk/status")
        assert resp.status_code == 200
        data = resp.json()
        assert data["running"] is True

    def test_status_lists_providers(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        assert "providers" in data
        assert len(data["providers"]) == 2

    def test_status_provider_health(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        for provider in data["providers"]:
            assert "name" in provider
            assert "healthy" in provider
            assert provider["healthy"] is True

    def test_status_provider_ids(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        ids = {p["id"] for p in data["providers"]}
        assert "lambda:myFunc" in ids
        assert "dynamodb" in ids


class TestInvokeEndpoint:
    """Tests for POST /_ldk/invoke."""

    def test_invoke_returns_payload(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "myFunc", "event": {"key": "value"}},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["payload"] == {"statusCode": 200, "body": '{"id": 1}'}
        assert data["error"] is None

    def test_invoke_unknown_function_returns_404(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "nonexistent", "event": {}},
        )
        assert resp.status_code == 404
        data = resp.json()
        assert "error" in data
        assert "nonexistent" in data["error"]

    def test_invoke_with_empty_event(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "myFunc"},
        )
        assert resp.status_code == 200
        assert resp.json()["error"] is None

    def test_invoke_error_function(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "errorFunc", "event": {}},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["error"] == "handler error"


class TestResetEndpoint:
    """Tests for POST /_ldk/reset."""

    def test_reset_returns_ok(self, client):
        resp = client.post("/_ldk/reset")
        assert resp.status_code == 200
        data = resp.json()
        assert data["status"] == "ok"

    def test_reset_returns_provider_count(self, client):
        resp = client.post("/_ldk/reset")
        data = resp.json()
        assert "providers_reset" in data
        # No providers have a reset() method, so count should be 0
        assert data["providers_reset"] == 0
