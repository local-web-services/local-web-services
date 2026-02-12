"""Shared fixtures for OpenSearch integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.opensearch.routes import create_opensearch_app


@pytest.fixture
async def provider():
    """OpenSearch uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    return create_opensearch_app()


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
