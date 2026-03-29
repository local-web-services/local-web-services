"""Shared fixtures and BDD step definitions for S3 Tables integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.s3tables.routes import create_s3tables_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_s3tables_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
