"""Tests for AwsCloudTrailMiddleware no-op behaviour when provider is absent."""

from __future__ import annotations

from unittest.mock import MagicMock

from starlette.testclient import TestClient

from lws.providers._shared.aws_cloudtrail_middleware import AwsCloudTrailMiddleware


def _make_app_with_middleware(provider):
    from fastapi import FastAPI  # pylint: disable=import-outside-toplevel

    app = FastAPI()
    app.add_middleware(AwsCloudTrailMiddleware, service="sqs", cloudtrail_provider=provider)

    @app.get("/")
    async def root():
        return {"ok": True}

    return app


class TestCloudTrailMiddlewareNoOp:
    """Middleware is a no-op when no CloudTrail provider is wired."""

    def test_request_succeeds_without_provider(self) -> None:
        # Arrange
        app = _make_app_with_middleware(provider=None)
        client = TestClient(app)

        # Act
        actual = client.get("/")

        # Assert
        expected_status = 200
        assert actual.status_code == expected_status

    def test_request_succeeds_with_provider(self) -> None:
        # Arrange
        mock_provider = MagicMock()
        mock_provider.record_event = MagicMock()
        app = _make_app_with_middleware(provider=mock_provider)
        client = TestClient(app)

        # Act
        actual = client.get("/")

        # Assert
        expected_status = 200
        assert actual.status_code == expected_status

    def test_internal_path_skipped(self) -> None:
        # Arrange
        mock_provider = MagicMock()
        mock_provider.record_event = MagicMock()
        app = _make_app_with_middleware(provider=mock_provider)
        client = TestClient(app)

        # Act
        client.get("/_ldk/health")

        # Assert
        mock_provider.record_event.assert_not_called()
