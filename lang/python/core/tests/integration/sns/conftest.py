"""Shared fixtures and BDD step definitions for SNS integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    p = SnsProvider(
        topics=[
            TopicConfig(
                topic_name="test-topic",
                topic_arn="arn:aws:sns:us-east-1:123456789012:test-topic",
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sns_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
