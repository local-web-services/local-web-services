"""Unit tests for the lws status command."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock, patch

import httpx
import pytest

from lws.cli.lws import _run_status

SAMPLE_STATUS = {
    "running": True,
    "providers": [
        {"id": "DynamoTable", "name": "dynamodb", "healthy": True},
        {"id": "MyQueue", "name": "sqs", "healthy": True},
    ],
}

SAMPLE_RESOURCES = {
    "services": {
        "dynamodb": {
            "port": 3001,
            "resources": [{"name": "Orders"}],
        },
        "sqs": {
            "port": 3002,
            "resources": [{"name": "MyQueue"}, {"name": "DLQ"}],
        },
    },
}


def _mock_client(status_resp, resources_resp):
    """Return a patched httpx.AsyncClient context manager."""
    patcher = patch("lws.cli.lws.httpx.AsyncClient")
    mock_cls = patcher.start()
    instance = AsyncMock()
    instance.get.side_effect = [status_resp, resources_resp]
    instance.__aenter__ = AsyncMock(return_value=instance)
    instance.__aexit__ = AsyncMock(return_value=False)
    mock_cls.return_value = instance
    return patcher


class TestLwsStatus:
    @pytest.mark.asyncio
    async def test_json_flag_outputs_json(self, capsys):
        status_resp = httpx.Response(
            200,
            json=SAMPLE_STATUS,
            request=httpx.Request("GET", "http://localhost:3000/_ldk/status"),
        )
        resources_resp = httpx.Response(
            200,
            json=SAMPLE_RESOURCES,
            request=httpx.Request("GET", "http://localhost:3000/_ldk/resources"),
        )

        patcher = _mock_client(status_resp, resources_resp)
        try:
            await _run_status(3000, json_output=True)
        finally:
            patcher.stop()

        output = json.loads(capsys.readouterr().out)
        assert output["running"] is True
        assert len(output["providers"]) == 2
        assert output["providers"][0]["name"] == "dynamodb"
        assert len(output["services"]) == 2
        assert output["services"][0]["name"] == "dynamodb"
        assert output["services"][0]["port"] == 3001
        assert output["services"][0]["resources"] == 1
        assert output["services"][1]["resources"] == 2

    @pytest.mark.asyncio
    async def test_default_outputs_table(self, capsys):
        status_resp = httpx.Response(
            200,
            json=SAMPLE_STATUS,
            request=httpx.Request("GET", "http://localhost:3000/_ldk/status"),
        )
        resources_resp = httpx.Response(
            200,
            json=SAMPLE_RESOURCES,
            request=httpx.Request("GET", "http://localhost:3000/_ldk/resources"),
        )

        patcher = _mock_client(status_resp, resources_resp)
        try:
            await _run_status(3000)
        finally:
            patcher.stop()

        output = capsys.readouterr().out
        assert "LDK is running" in output
        assert "dynamodb" in output
        assert "sqs" in output
        assert "healthy" in output
        assert "3001" in output
        assert "3002" in output

    @pytest.mark.asyncio
    async def test_status_exits_when_not_running(self):
        with patch("lws.cli.lws.httpx.AsyncClient") as mock_cls:
            instance = AsyncMock()
            instance.get.side_effect = httpx.ConnectError("connection refused")
            instance.__aenter__ = AsyncMock(return_value=instance)
            instance.__aexit__ = AsyncMock(return_value=False)
            mock_cls.return_value = instance

            with pytest.raises(SystemExit):
                await _run_status(3000)

    def test_status_appears_in_help(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["--help"])
        assert "status" in result.output
