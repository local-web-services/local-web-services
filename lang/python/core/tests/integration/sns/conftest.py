"""Shared fixtures for SNS integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app


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
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
