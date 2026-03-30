"""Fixtures for DynamoDB integration tests."""

from __future__ import annotations

from pathlib import Path

import pytest
from starlette.testclient import TestClient

from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider(tmp_path: Path):
    p = SqliteDynamoProvider(
        data_dir=tmp_path,
        tables=[],
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_dynamodb_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
