"""Shared fixtures and BDD step definitions for Lambda integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.lambda_runtime.routes import (
    LambdaRegistry,
    create_lambda_management_app,
)

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    """Lambda invoke uses the Lambda management API; no dedicated provider needed."""
    yield None


@pytest.fixture
def app(provider):
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
