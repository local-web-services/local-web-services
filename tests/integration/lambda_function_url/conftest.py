"""Shared fixtures for Lambda Function URL integration tests."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any

import httpx
import pytest

from lws.providers.lambda_function_url.routes import create_lambda_function_url_app


@dataclass
class MockInvokeResult:
    """Mimics the ICompute invoke result."""

    payload: Any = None
    error: str | None = None


class MockCompute:
    """A mock ICompute that returns a configurable response."""

    def __init__(self, response: dict | None = None, error: str | None = None):
        self._response = response or {"statusCode": 200, "body": "OK"}
        self._error = error
        self.last_event: dict | None = None

    async def start(self) -> None:
        pass

    async def stop(self) -> None:
        pass

    async def invoke(self, event: dict, context: Any) -> MockInvokeResult:
        self.last_event = event
        if self._error:
            return MockInvokeResult(error=self._error)
        return MockInvokeResult(payload=self._response)


@pytest.fixture
def mock_compute():
    return MockCompute()


@pytest.fixture
async def provider(mock_compute):
    await mock_compute.start()
    yield mock_compute
    await mock_compute.stop()


@pytest.fixture
def app(provider):
    return create_lambda_function_url_app("test-function", provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
