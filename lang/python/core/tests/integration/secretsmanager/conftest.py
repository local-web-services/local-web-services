"""Shared fixtures for Secrets Manager integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.secretsmanager.routes import create_secretsmanager_app


@pytest.fixture
async def provider():
    """Secrets Manager uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_secretsmanager_app()
    return app


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
