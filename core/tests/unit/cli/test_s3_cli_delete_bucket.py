"""Tests for S3 CLI bucket management commands."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


def _fake_client_rest(
    status_code: int = 200,
    text: str = "",
    headers: dict | None = None,
) -> AsyncMock:
    fake = AsyncMock()
    fake.service_port = AsyncMock(return_value=3003)
    resp = MagicMock()
    resp.status_code = status_code
    resp.text = text
    resp.content = text.encode()
    resp.headers = headers or {}
    fake.rest_request = AsyncMock(return_value=resp)
    return fake


class TestDeleteBucket:
    def test_delete_bucket_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_method = "DELETE"
        expected_bucket = "my-bucket"
        fake = _fake_client_rest(204)

        # Act
        with patch("lws.cli.services.s3._client", return_value=fake):
            result = runner.invoke(
                app,
                ["s3api", "delete-bucket", "--bucket", expected_bucket],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.rest_request.assert_awaited_once()
        call_args = fake.rest_request.call_args
        actual_method = call_args[0][1]
        actual_bucket = call_args[0][2]
        assert actual_method == expected_method
        assert actual_bucket == expected_bucket
