"""Shared fixtures for SQS integration tests."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app


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
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
