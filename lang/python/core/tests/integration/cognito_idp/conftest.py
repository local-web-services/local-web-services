"""Shared fixtures and BDD step definitions for Cognito IDP integration tests."""

from __future__ import annotations

from pathlib import Path

import pytest
from starlette.testclient import TestClient

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig

from .constants import INT_CLIENT_ID, INT_POOL_ID

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider(tmp_path: Path):

    p = CognitoProvider(
        data_dir=tmp_path,
        config=UserPoolConfig(
            user_pool_id=INT_POOL_ID,
            auto_confirm=True,
            client_id=INT_CLIENT_ID,
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
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
