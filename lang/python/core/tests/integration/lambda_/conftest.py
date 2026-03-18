"""Shared fixtures for Lambda integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app


@pytest.fixture
async def provider():
    """Lambda invoke uses the Lambda management API; no dedicated provider needed."""
    yield None


@pytest.fixture
def app(provider):
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
