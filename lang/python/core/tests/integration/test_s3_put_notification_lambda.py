"""Integration tests for PUT /?notification with LambdaFunctionConfigurations."""

from __future__ import annotations

from pathlib import Path
from unittest.mock import MagicMock

import httpx
import pytest

from lws.providers.s3.provider import S3Provider
from lws.providers.s3.routes import create_s3_app

_BUCKET = "test-notification-bucket"
_FUNC_NAME = "my-notification-func"
_FUNC_ARN = f"arn:aws:lambda:us-east-1:000000000000:function:{_FUNC_NAME}"
_NOTIFICATION_XML = (
    '<?xml version="1.0" encoding="UTF-8"?>'
    "<NotificationConfiguration>"
    "<CloudFunctionConfiguration>"
    f"<CloudFunction>{_FUNC_ARN}</CloudFunction>"
    "<Event>s3:ObjectCreated:*</Event>"
    "</CloudFunctionConfiguration>"
    "</NotificationConfiguration>"
)


class TestS3PutNotificationLambda:
    """Tests for PutBucketNotificationConfiguration with Lambda targets."""

    @pytest.fixture
    async def provider(self, tmp_path: Path):
        """Create an S3 provider with one pre-seeded bucket."""
        p = S3Provider(data_dir=tmp_path, buckets=[_BUCKET])
        await p.start()
        yield p
        await p.stop()

    @pytest.fixture
    def compute_providers(self):
        """Return a compute_providers dict with one mock Lambda function."""
        mock_compute = MagicMock()
        return {_FUNC_NAME: mock_compute}

    @pytest.fixture
    async def client_with_compute(self, provider, compute_providers):
        """Create an HTTP client wired with compute providers."""
        app = create_s3_app(provider, compute_providers=compute_providers)
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    @pytest.fixture
    async def client_no_compute(self, provider):
        """Create an HTTP client without compute providers."""
        app = create_s3_app(provider)
        transport = httpx.ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
            yield c

    async def test_put_notification_with_valid_lambda_function_returns_200(
        self,
        client_with_compute: httpx.AsyncClient,
    ) -> None:
        # Arrange
        expected_status_code = 200
        url = f"/{_BUCKET}?notification"

        # Act
        actual_response = await client_with_compute.put(
            url,
            content=_NOTIFICATION_XML.encode(),
            headers={"Content-Type": "application/xml"},
        )

        # Assert
        assert actual_response.status_code == expected_status_code, (
            f"Expected status {expected_status_code} but got "
            f"{actual_response.status_code}: {actual_response.text}"
        )

    async def test_put_notification_with_missing_lambda_function_returns_400(
        self,
        client_no_compute: httpx.AsyncClient,
    ) -> None:
        # Arrange
        expected_status_code = 400
        url = f"/{_BUCKET}?notification"

        # Act
        actual_response = await client_no_compute.put(
            url,
            content=_NOTIFICATION_XML.encode(),
            headers={"Content-Type": "application/xml"},
        )

        # Assert
        assert actual_response.status_code == expected_status_code, (
            f"Expected status {expected_status_code} but got "
            f"{actual_response.status_code}: {actual_response.text}"
        )
