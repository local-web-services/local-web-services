from __future__ import annotations

from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.interfaces import ICompute, InvocationResult, LambdaContext
from lws.interfaces.provider import Provider
from lws.providers._shared.async_state_store import AsyncStateStore
from lws.providers._shared.aws_lifecycle import TrackerRegistry
from lws.runtime.orchestrator import Orchestrator


def make_registry_client(
    state_store: AsyncStateStore,
    tracker_registry: TrackerRegistry | None = None,
) -> TestClient:
    """Build a TestClient wired to a management router with optional tracker registry."""
    orchestrator = Orchestrator()
    orchestrator._running = True
    providers: dict = {"dynamodb": FakeProvider("dynamodb")}
    orchestrator._providers = providers
    router = create_management_router(
        orchestrator=orchestrator,
        providers=providers,
        state_store=state_store,
        tracker_registry=tracker_registry,
    )
    app = FastAPI()
    app.include_router(router)
    return TestClient(app)


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
