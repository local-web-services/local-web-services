"""Shared fixtures for Neptune integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.neptune.routes import create_neptune_app


@pytest.fixture
async def provider():
    """Neptune uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_neptune_app()


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
