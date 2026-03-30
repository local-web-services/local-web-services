"""Shared fixtures and BDD step definitions for S3api integration tests."""

from __future__ import annotations

from pathlib import Path

import pytest
from starlette.testclient import TestClient

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path, buckets=[])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_s3_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


@pytest.fixture
def sync_client(app):
    with TestClient(app, base_url="http://testserver", raise_server_exceptions=True) as c:
        yield c
