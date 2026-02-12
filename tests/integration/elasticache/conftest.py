"""Shared fixtures for ElastiCache integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.elasticache.routes import create_elasticache_app


@pytest.fixture
async def provider():
    """ElastiCache uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_elasticache_app()


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
