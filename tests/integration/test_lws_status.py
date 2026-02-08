"""Integration test for the lws status command against a running management API."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path

import uvicorn
from fastapi import FastAPI

from ldk.api.management import create_management_router
from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.providers.dynamodb.provider import SqliteDynamoProvider
from ldk.runtime.orchestrator import Orchestrator


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
            compute_providers={},
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
            # Run the actual lws status command
            from ldk.cli.lws import _run_status

            # Test JSON output mode
            await _run_status(port, json_output=True)

            output = json.loads(capsys.readouterr().out)

            assert output["running"] is True
            assert len(output["providers"]) == 1
            assert output["providers"][0]["name"] == "dynamodb"
            assert output["providers"][0]["healthy"] is True
            assert len(output["services"]) == 1
            assert output["services"][0]["name"] == "dynamodb"
            assert output["services"][0]["port"] == 3001
            assert output["services"][0]["resources"] == 1

            # Test default table output mode
            await _run_status(port)

            table_output = capsys.readouterr().out
            assert "LDK is running" in table_output
            assert "dynamodb" in table_output
            assert "healthy" in table_output
            assert "3001" in table_output
        finally:
            server.should_exit = True
            await serve_task
            await orchestrator.stop()
