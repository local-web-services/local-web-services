"""Shared fixtures for S3 Tables integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.s3tables.routes import create_s3tables_app


@pytest.fixture
async def provider():
    yield None


@pytest.fixture
def app(provider):
    return create_s3tables_app()


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
