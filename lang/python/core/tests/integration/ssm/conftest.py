"""Shared fixtures and BDD step definitions for SSM integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.ssm.routes import create_ssm_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    """SSM uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_ssm_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
