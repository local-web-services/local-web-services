"""Integration test for the lws status command against a running management API."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path

import uvicorn
from fastapi import FastAPI

from lws.api.management import create_management_router
from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.runtime.orchestrator import Orchestrator


class TestLwsStatusIntegration:
    async def test_status_returns_provider_info(self, tmp_path: Path, capsys):
        # Set up a real provider
        dynamo = SqliteDynamoProvider(
            data_dir=tmp_path,
            tables=[
                TableConfig(
                    table_name="StatusTestTable",
                    key_schema=KeySchema(
                        partition_key=KeyAttribute(name="pk", type="S"),
                    ),
                ),
            ],
        )
        await dynamo.start()

        # Set up orchestrator with the provider
        providers = {"dynamo_node": dynamo}
        orchestrator = Orchestrator()
        await orchestrator.start(providers, ["dynamo_node"])

        resource_metadata = {
            "services": {
                "dynamodb": {
                    "port": 3001,
                    "resources": [{"name": "StatusTestTable"}],
                },
            },
        }

        # Build a FastAPI app with the management router
        app = FastAPI()
        router = create_management_router(
            orchestrator,
            providers=providers,
            resource_metadata=resource_metadata,
        )
        app.include_router(router)

        # Start a real uvicorn server
        port = 19876
        config = uvicorn.Config(app=app, host="127.0.0.1", port=port, log_level="warning")
        server = uvicorn.Server(config)
        serve_task = asyncio.create_task(server.serve())
        for _ in range(50):
            if server.started:
                break
            await asyncio.sleep(0.1)

        try:
            # Arrange
            expected_provider_name = "dynamodb"
            expected_provider_count = 1
            expected_service_count = 1
            expected_service_port = 3001
            expected_resource_count = 1
            expected_running_message = "LDK is running"
            expected_health_status = "healthy"

            # Run the actual lws status command
            from lws.cli.lws import _run_status

            # Act - JSON output mode
            await _run_status(port, json_output=True)

            # Assert - JSON output mode
            output = json.loads(capsys.readouterr().out)

            assert output["running"] is True
            actual_provider_count = len(output["providers"])
            assert actual_provider_count == expected_provider_count
            actual_provider_name = output["providers"][0]["name"]
            assert actual_provider_name == expected_provider_name
            assert output["providers"][0]["healthy"] is True
            actual_service_count = len(output["services"])
            assert actual_service_count == expected_service_count
            actual_service_name = output["services"][0]["name"]
            assert actual_service_name == expected_provider_name
            actual_service_port = output["services"][0]["port"]
            assert actual_service_port == expected_service_port
            actual_resource_count = output["services"][0]["resources"]
            assert actual_resource_count == expected_resource_count

            # Act - default table output mode
            await _run_status(port)

            # Assert - table output mode
            table_output = capsys.readouterr().out
            assert expected_running_message in table_output
            assert expected_provider_name in table_output
            assert expected_health_status in table_output
            assert str(expected_service_port) in table_output
        finally:
            server.should_exit = True
            await serve_task
            await orchestrator.stop()
