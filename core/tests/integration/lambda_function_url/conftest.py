"""Shared fixtures for Lambda Function URL integration tests."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any

import httpx
import pytest

from lws.providers.lambda_function_url.routes import create_lambda_function_url_app


@dataclass
class FakeInvokeResult:
    """Mimics the ICompute invoke result."""

    payload: Any = None
    error: str | None = None


class FakeCompute:
    """A fake ICompute that returns a configurable response."""

    def __init__(self, response: dict | None = None, error: str | None = None):
        self._response = response or {"statusCode": 200, "body": "OK"}
        self._error = error
        self.last_event: dict | None = None

    async def start(self) -> None:
        pass

    async def stop(self) -> None:
        pass

    async def invoke(self, event: dict, context: Any) -> FakeInvokeResult:
        self.last_event = event
        if self._error:
            return FakeInvokeResult(error=self._error)
        return FakeInvokeResult(payload=self._response)


@pytest.fixture
def fake_compute():
    return FakeCompute()


@pytest.fixture
async def provider(fake_compute):
    await fake_compute.start()
    yield fake_compute
    await fake_compute.stop()


@pytest.fixture
def app(provider):
    return create_lambda_function_url_app("test-function", provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c
