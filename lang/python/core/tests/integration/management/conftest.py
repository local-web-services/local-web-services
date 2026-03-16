"""Shared fixtures for management API integration tests."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.api.management import create_management_router
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.runtime.orchestrator import Orchestrator


@pytest.fixture
def lifecycle_configs():
    """Mutable lifecycle config map shared between fixture and tests."""
    return {
        "dynamodb": ResourceLifecycleConfig(),
        "s3": ResourceLifecycleConfig(),
    }


@pytest.fixture
async def provider(lifecycle_configs):
    """Management router uses no stateful provider; yields None."""
    yield None


@pytest.fixture
def app(provider, lifecycle_configs):
    """Create a FastAPI app with the management router wired to lifecycle_configs."""
    orchestrator = Orchestrator()
    orchestrator._running = True
    router = create_management_router(
        orchestrator=orchestrator,
        lifecycle_configs=lifecycle_configs,
    )
    fastapi_app = FastAPI()
    fastapi_app.include_router(router)
    return fastapi_app


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
