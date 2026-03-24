"""Integration tests for the RDS Data API POST /execute endpoint."""

from __future__ import annotations

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.rds.routes import create_rds_app

_CLUSTER_ID = "int-rds-execute-cluster-1"
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_CLUSTER_ARN = f"arn:aws:rds:{_REGION}:{_ACCOUNT}:cluster:{_CLUSTER_ID}"
_SECRET_ARN = f"arn:aws:secretsmanager:{_REGION}:{_ACCOUNT}:secret:rds-secret"
_RDS_TARGET = "AmazonRDSv19"


@pytest.fixture
async def client():
    app = create_rds_app()
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


async def _create_cluster(client: AsyncClient, cluster_id: str = _CLUSTER_ID) -> dict:
    resp = await client.post(
        "/",
        headers={"X-Amz-Target": f"{_RDS_TARGET}.CreateDBCluster"},
        json={"DBClusterIdentifier": cluster_id, "Engine": "aurora-postgresql"},
    )
    return resp.json()


async def _execute_sql(
    client: AsyncClient,
    resource_arn: str,
    sql: str,
    parameters: list | None = None,
) -> dict:
    payload: dict = {
        "resourceArn": resource_arn,
        "secretArn": _SECRET_ARN,
        "sql": sql,
    }
    if parameters is not None:
        payload["parameters"] = parameters
    resp = await client.post("/execute", json=payload)
    return resp.json()


class TestRdsExecuteStatement:
    @pytest.mark.asyncio
    async def test_execute_ddl_returns_200(self, client: AsyncClient) -> None:
        # Arrange
        await _create_cluster(client)
        expected_status = 200

        # Act
        actual_response = await client.post(
            "/execute",
            json={
                "resourceArn": _CLUSTER_ARN,
                "secretArn": _SECRET_ARN,
                "sql": "CREATE TABLE int_items (id INTEGER PRIMARY KEY, name TEXT)",
            },
        )

        # Assert
        assert actual_response.status_code == expected_status, (
            f"Expected {expected_status!r} but got {actual_response.status_code!r}: "
            f"{actual_response.text}"
        )

    @pytest.mark.asyncio
    async def test_execute_select_after_insert_returns_rows(self, client: AsyncClient) -> None:
        # Arrange
        await _create_cluster(client)
        await _execute_sql(
            client,
            _CLUSTER_ARN,
            "CREATE TABLE int_rows (id INTEGER, label TEXT)",
        )
        await _execute_sql(client, _CLUSTER_ARN, "INSERT INTO int_rows VALUES (1, 'hello')")
        expected_record_count = 1

        # Act
        actual_result = await _execute_sql(client, _CLUSTER_ARN, "SELECT id, label FROM int_rows")

        # Assert
        actual_record_count = len(actual_result.get("records", []))
        assert (
            actual_record_count == expected_record_count
        ), f"Expected {expected_record_count!r} records but got {actual_record_count!r}"

    @pytest.mark.asyncio
    async def test_execute_with_unknown_cluster_returns_400(self, client: AsyncClient) -> None:
        # Arrange
        unknown_arn = "arn:aws:rds:us-east-1:000000000000:cluster:no-such-cluster"
        expected_status = 400

        # Act
        actual_response = await client.post(
            "/execute",
            json={"resourceArn": unknown_arn, "secretArn": _SECRET_ARN, "sql": "SELECT 1"},
        )

        # Assert
        assert (
            actual_response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {actual_response.status_code!r}"

    @pytest.mark.asyncio
    async def test_execute_float_column_maps_to_double_value(self, client: AsyncClient) -> None:
        # Arrange
        await _create_cluster(client)
        await _execute_sql(client, _CLUSTER_ARN, "CREATE TABLE int_floats (val REAL)")
        await _execute_sql(client, _CLUSTER_ARN, "INSERT INTO int_floats VALUES (3.14)")
        expected_key = "doubleValue"

        # Act
        actual_result = await _execute_sql(client, _CLUSTER_ARN, "SELECT val FROM int_floats")

        # Assert
        actual_field = actual_result["records"][0][0]
        assert (
            expected_key in actual_field
        ), f"Expected key {expected_key!r} in field {actual_field!r}"
