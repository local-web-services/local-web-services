"""Tests for S3 Bucket Notification Configuration operations."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path)
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: S3Provider) -> httpx.AsyncClient:
    app = create_s3_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestBucketNotificationConfiguration:
    @pytest.mark.asyncio
    async def test_put_and_get_notification_configuration(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        bucket_name = "my-bucket"
        await provider.create_bucket(bucket_name)
        expected_status = 200

        config_xml = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<NotificationConfiguration>"
            "<TopicConfiguration>"
            "<Topic>arn:aws:sns:us-east-1:000000000000:my-topic</Topic>"
            "<Event>s3:ObjectCreated:*</Event>"
            "</TopicConfiguration>"
            "</NotificationConfiguration>"
        )

        # Act
        put_resp = await client.put(
            f"/{bucket_name}?notification",
            content=config_xml.encode(),
            headers={"content-type": "application/xml"},
        )
        get_resp = await client.get(f"/{bucket_name}?notification")

        # Assert
        assert put_resp.status_code == expected_status
        assert get_resp.status_code == expected_status
        assert "<NotificationConfiguration>" in get_resp.text
        assert "my-topic" in get_resp.text

    @pytest.mark.asyncio
    async def test_get_notification_configuration_default(
        self, client: httpx.AsyncClient, provider: S3Provider
    ) -> None:
        # Arrange
        await provider.create_bucket("my-bucket")
        expected_status = 200

        # Act
        resp = await client.get("/my-bucket?notification")

        # Assert
        assert resp.status_code == expected_status
        assert "<NotificationConfiguration/>" in resp.text

    @pytest.mark.asyncio
    async def test_put_notification_configuration_no_such_bucket(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        expected_status = 404

        # Act
        config_xml = "<NotificationConfiguration/>"
        resp = await client.put(
            "/nonexistent-bucket?notification",
            content=config_xml.encode(),
            headers={"content-type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_status
        assert "NoSuchBucket" in resp.text

    @pytest.mark.asyncio
    async def test_get_notification_configuration_no_such_bucket(
        self, client: httpx.AsyncClient
    ) -> None:
        # Act
        resp = await client.get("/nonexistent-bucket?notification")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        assert "NoSuchBucket" in resp.text
