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


class TestCreateBucket:
    def test_create_bucket_calls_correct_endpoint(self) -> None:
        mock = _mock_client_rest(200)
        with patch("lws.cli.services.s3._client", return_value=mock):
            result = runner.invoke(
                app,
                ["s3api", "create-bucket", "--bucket", "my-bucket"],
            )

        assert result.exit_code == 0
        mock.rest_request.assert_awaited_once()
        call_args = mock.rest_request.call_args
        assert call_args[0][1] == "PUT"
        assert call_args[0][2] == "my-bucket"
