"""Tests for S3 CLI bucket management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _mock_client_rest(
    status_code: int = 200,
    text: str = "",
    headers: dict | None = None,
) -> AsyncMock:
    mock = AsyncMock()
    mock.service_port = AsyncMock(return_value=3003)
    resp = MagicMock()
    resp.status_code = status_code
    resp.text = text
    resp.content = text.encode()
    resp.headers = headers or {}
    mock.rest_request = AsyncMock(return_value=resp)
    return mock


class TestListBuckets:
    def test_list_buckets_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_method = "GET"
        expected_path = ""
        xml = (
            '<?xml version="1.0" encoding="UTF-8"?>'
            "<ListAllMyBucketsResult>"
            "<Buckets>"
            "<Bucket><Name>my-bucket</Name><CreationDate>2024-01-01T00:00:00.000Z</CreationDate></Bucket>"
            "</Buckets>"
            "</ListAllMyBucketsResult>"
        )
        mock = _mock_client_rest(200, text=xml)

        # Act
        with patch("lws.cli.services.s3._client", return_value=mock):
            result = runner.invoke(
                app,
                ["s3api", "list-buckets"],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        mock.rest_request.assert_awaited_once()
        call_args = mock.rest_request.call_args
        actual_method = call_args[0][1]
        actual_path = call_args[0][2]
        assert actual_method == expected_method
        assert actual_path == expected_path
