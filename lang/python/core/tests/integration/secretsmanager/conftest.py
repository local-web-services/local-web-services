"""Shared fixtures and BDD step definitions for Secrets Manager integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.secretsmanager.routes import create_secretsmanager_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


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
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


@pytest.fixture
def sync_client(app):
    with TestClient(app, base_url="http://testserver", raise_server_exceptions=True) as c:
        yield c
