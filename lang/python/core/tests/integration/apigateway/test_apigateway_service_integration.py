"""Integration tests for API Gateway V1 service integration dispatch."""

from __future__ import annotations

import json
import tempfile
from pathlib import Path

import pytest
from httpx import ASGITransport, AsyncClient

from lws.interfaces.key_value_store import KeyAttribute, KeySchema, TableConfig
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.sqs.provider import QueueConfig, SqsProvider

_ITEM_TABLE = "int-apigw-svc-table-1"
_ITEM_KEY_ATTR = "id"
_SQS_QUEUE = "int-apigw-svc-queue-1"
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_STAGE_NAME = "test"


@pytest.fixture
async def dynamo_provider():
    with tempfile.TemporaryDirectory() as tmp:
        table_config = TableConfig(
            table_name=_ITEM_TABLE,
            key_schema=KeySchema(partition_key=KeyAttribute(name=_ITEM_KEY_ATTR, type="S")),
        )
        provider = SqliteDynamoProvider(
            data_dir=Path(tmp) / "dynamodb",
            tables=[table_config],
        )
        await provider.start()
        yield provider
        await provider.stop()


@pytest.fixture
async def sqs_provider():
    provider = SqsProvider(queues=[QueueConfig(queue_name=_SQS_QUEUE)])
    await provider.start()
    yield provider
    await provider.stop()


@pytest.fixture
async def apigw_client_with_dynamo(dynamo_provider):
    service_providers = {"dynamodb": dynamo_provider}
    app, _ = create_apigateway_management_app(service_providers=service_providers)
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


@pytest.fixture
async def apigw_client_with_sqs(sqs_provider):
    service_providers = {"sqs": sqs_provider}
    app, _ = create_apigateway_management_app(service_providers=service_providers)
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


async def _setup_v1_api_with_integration(
    client: AsyncClient,
    api_name: str,
    http_method: str,
    integration_uri: str,
) -> tuple[str, str]:
    """Create a REST API, root resource method+integration, deployment, and stage.

    Returns (api_id, root_resource_id).
    """
    create_resp = await client.post("/restapis", json={"name": api_name})
    api_data = create_resp.json()
    api_id = api_data["id"]
    root_resource_id = api_data["rootResourceId"]

    await client.put(
        f"/restapis/{api_id}/resources/{root_resource_id}/methods/{http_method}",
        json={"authorizationType": "NONE"},
    )

    await client.put(
        f"/restapis/{api_id}/resources/{root_resource_id}/methods/{http_method}/integration",
        json={"type": "AWS", "uri": integration_uri, "integrationHttpMethod": "POST"},
    )

    deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
    deployment_id = deploy_resp.json()["id"]

    await client.post(
        f"/restapis/{api_id}/stages",
        json={"stageName": _STAGE_NAME, "deploymentId": deployment_id},
    )

    return api_id, root_resource_id


class TestApiGatewayDynamoDbIntegration:
    @pytest.mark.asyncio
    async def test_put_item_via_apigw_integration_returns_200(
        self, apigw_client_with_dynamo: AsyncClient
    ) -> None:
        # Arrange
        integration_uri = f"arn:aws:apigateway:{_REGION}:dynamodb:action/PutItem"
        api_id, _ = await _setup_v1_api_with_integration(
            apigw_client_with_dynamo, "dynamo-api-1", "POST", integration_uri
        )
        request_body = {
            "TableName": _ITEM_TABLE,
            "Item": {_ITEM_KEY_ATTR: {"S": "item-1"}, "value": {"S": "hello"}},
        }
        expected_status = 200

        # Act
        actual_response = await apigw_client_with_dynamo.post(
            f"/{api_id}/{_STAGE_NAME}/",
            content=json.dumps(request_body),
            headers={"Content-Type": "application/json"},
        )

        # Assert
        assert actual_response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {actual_response.status_code!r}: "
            f"{actual_response.text}"
        )

    @pytest.mark.asyncio
    async def test_unknown_api_id_returns_404(self, apigw_client_with_dynamo: AsyncClient) -> None:
        # Arrange
        unknown_api_id = "zzz999zzz9"
        expected_status = 404

        # Act
        actual_response = await apigw_client_with_dynamo.post(
            f"/{unknown_api_id}/prod/",
            content=json.dumps({}),
            headers={"Content-Type": "application/json"},
        )

        # Assert
        assert (
            actual_response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {actual_response.status_code!r}"


class TestApiGatewaySqsIntegration:
    @pytest.mark.asyncio
    async def test_send_message_via_apigw_integration_returns_200(
        self, apigw_client_with_sqs: AsyncClient
    ) -> None:
        # Arrange
        integration_uri = f"arn:aws:apigateway:{_REGION}:sqs:path/{_ACCOUNT}/{_SQS_QUEUE}"
        api_id, _ = await _setup_v1_api_with_integration(
            apigw_client_with_sqs, "sqs-api-1", "POST", integration_uri
        )
        request_body = {"event": "order-created", "orderId": "123"}
        expected_status = 200

        # Act
        actual_response = await apigw_client_with_sqs.post(
            f"/{api_id}/{_STAGE_NAME}/",
            content=json.dumps(request_body),
            headers={"Content-Type": "application/json"},
        )

        # Assert
        assert actual_response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {actual_response.status_code!r}: "
            f"{actual_response.text}"
        )
        actual_body = actual_response.json()
        expected_key = "MessageId"
        assert (
            expected_key in actual_body
        ), f"Expected {expected_key!r} in response body but got: {actual_body!r}"
