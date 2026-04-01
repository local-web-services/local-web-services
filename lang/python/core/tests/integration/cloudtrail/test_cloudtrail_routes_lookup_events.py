"""Integration tests for CloudTrail LookupEvents HTTP wire protocol."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.cloudtrail._event_builder import build_cloudtrail_event
from lws.providers.cloudtrail.provider import CloudTrailProvider
from lws.providers.cloudtrail.routes import create_cloudtrail_app

_TARGET_BASE = "CloudTrail_20131101."


def _headers(action: str) -> dict:
    return {
        "x-amz-target": f"{_TARGET_BASE}{action}",
        "Content-Type": "application/x-amz-json-1.1",
    }


@pytest.fixture
def provider():
    p = CloudTrailProvider()
    for i in range(5):
        p.record_event(
            build_cloudtrail_event(
                service="sqs",
                operation=f"Op{i}",
                source_ip="127.0.0.1",
                username="dev",
                status_code=200,
            )
        )
    return p


@pytest.fixture
async def client(provider):
    app = create_cloudtrail_app(provider)
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestCloudTrailRoutesLookupEvents:
    """LookupEvents HTTP wire protocol with filters and pagination."""

    async def test_lookup_returns_events(self, client) -> None:
        # Arrange
        # (provider fixture pre-loads 5 events)

        # Act
        actual = await client.post("/", headers=_headers("LookupEvents"), json={})

        # Assert
        expected_status = 200
        assert actual.status_code == expected_status
        assert len(actual.json()["Events"]) == 5

    async def test_lookup_filter_by_event_name(self, client) -> None:
        # Arrange
        body = {"LookupAttributes": [{"AttributeKey": "EventName", "AttributeValue": "Op0"}]}

        # Act
        actual = await client.post("/", headers=_headers("LookupEvents"), json=body)

        # Assert
        expected_count = 1
        assert actual.status_code == 200
        assert len(actual.json()["Events"]) == expected_count

    async def test_lookup_pagination(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(55):
            provider.record_event(
                build_cloudtrail_event(
                    service="sqs",
                    operation=f"Op{i}",
                    source_ip="127.0.0.1",
                    username="dev",
                    status_code=200,
                )
            )
        app = create_cloudtrail_app(provider)
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            # Act
            actual = await c.post("/", headers=_headers("LookupEvents"), json={"MaxResults": 50})

        # Assert
        expected_page_size = 50
        assert len(actual.json()["Events"]) == expected_page_size
        assert "NextToken" in actual.json()
