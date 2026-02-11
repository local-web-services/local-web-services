"""Shared fixtures for Cognito integration tests."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig


@pytest.fixture
async def provider(tmp_path: Path):
    p = CognitoProvider(
        data_dir=tmp_path,
        config=UserPoolConfig(
            user_pool_id="us-east-1_TestPool",
            auto_confirm=True,
            client_id="test-client",
        ),
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_cognito_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
