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


def _fake_client(status_resp, resources_resp):
    """Return a patched httpx.AsyncClient context manager."""
    patcher = patch("lws.cli.lws.httpx.AsyncClient")
    fake_cls = patcher.start()
    instance = AsyncMock()
    instance.get.side_effect = [status_resp, resources_resp]
    instance.__aenter__ = AsyncMock(return_value=instance)
    instance.__aexit__ = AsyncMock(return_value=False)
    fake_cls.return_value = instance
    return patcher


class TestLwsStatus:
    @pytest.mark.asyncio
    async def test_json_flag_outputs_json(self, capsys):
        # Arrange
        expected_provider_count = 2
        expected_first_provider_name = "dynamodb"
        expected_service_count = 2
        expected_first_service_name = "dynamodb"
        expected_first_service_port = 3001
        expected_first_service_resources = 1
        expected_second_service_resources = 2

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

        # Act
        patcher = _fake_client(status_resp, resources_resp)
        try:
            await _run_status(3000, json_output=True)
        finally:
            patcher.stop()

        # Assert
        output = json.loads(capsys.readouterr().out)
        assert output["running"] is True, "Expected value to be truthy"
        actual_provider_count = len(output["providers"])
        actual_first_provider_name = output["providers"][0]["name"]
        actual_service_count = len(output["services"])
        actual_first_service_name = output["services"][0]["name"]
        actual_first_service_port = output["services"][0]["port"]
        actual_first_service_resources = output["services"][0]["resources"]
        actual_second_service_resources = output["services"][1]["resources"]

        assert (
            actual_provider_count == expected_provider_count
        ), f"Expected {expected_provider_count!r} but got {actual_provider_count!r}"
        assert (
            actual_first_provider_name == expected_first_provider_name
        ), f"Expected {expected_first_provider_name!r} but got {actual_first_provider_name!r}"
        assert (
            actual_service_count == expected_service_count
        ), f"Expected {expected_service_count!r} but got {actual_service_count!r}"
        assert (
            actual_first_service_name == expected_first_service_name
        ), f"Expected {expected_first_service_name!r} but got {actual_first_service_name!r}"
        assert (
            actual_first_service_port == expected_first_service_port
        ), f"Expected {expected_first_service_port!r} but got {actual_first_service_port!r}"
        assert (
            actual_first_service_resources == expected_first_service_resources
        ), f"Expected {expected_first_service_resources!r}"
        assert (
            actual_second_service_resources == expected_second_service_resources
        ), f"Expected {expected_second_service_resources!r}"

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

        patcher = _fake_client(status_resp, resources_resp)
        try:
            await _run_status(3000)
        finally:
            patcher.stop()

        output = capsys.readouterr().out
        assert "LDK is running" in output, f'Expected {"LDK is running"!r} to be in {output!r}'
        assert "dynamodb" in output, f'Expected {"dynamodb"!r} to be in {output!r}'
        assert "sqs" in output, f'Expected {"sqs"!r} to be in {output!r}'
        assert "healthy" in output, f'Expected {"healthy"!r} to be in {output!r}'
        assert "3001" in output, f'Expected {"3001"!r} to be in {output!r}'
        assert "3002" in output, f'Expected {"3002"!r} to be in {output!r}'

    @pytest.mark.asyncio
    async def test_status_exits_when_not_running(self):
        with patch("lws.cli.lws.httpx.AsyncClient") as fake_cls:
            instance = AsyncMock()
            instance.get.side_effect = httpx.ConnectError("connection refused")
            instance.__aenter__ = AsyncMock(return_value=instance)
            instance.__aexit__ = AsyncMock(return_value=False)
            fake_cls.return_value = instance

            with pytest.raises(SystemExit):
                await _run_status(3000)

    def test_status_appears_in_help(self):
        from typer.testing import CliRunner

        from lws.cli.lws import app

        runner = CliRunner()
        result = runner.invoke(app, ["--help"])
        assert "status" in result.output, f'Expected {"status"!r} to be in {result.output!r}'
