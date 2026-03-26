"""Shared fixtures and BDD step definitions for SQS integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    p = SqsProvider(queues=[QueueConfig(queue_name="test-queue")])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sqs_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
