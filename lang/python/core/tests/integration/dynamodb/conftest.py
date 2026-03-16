"""Shared fixtures for DynamoDB integration tests."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.routes import create_dynamodb_app


@pytest.fixture
async def provider(tmp_path: Path):
    p = SqliteDynamoProvider(
        data_dir=tmp_path,
        tables=[
            TableConfig(
                table_name="TestTable",
                key_schema=KeySchema(partition_key=KeyAttribute(name="pk", type="S")),
            )
        ],
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_dynamodb_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
