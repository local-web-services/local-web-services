"""Shared fixtures for Glacier integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture
async def provider():
    """Glacier uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_glacier_app()


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
