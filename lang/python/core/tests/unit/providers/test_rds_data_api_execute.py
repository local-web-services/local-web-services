"""Unit tests for the RDS Data API /execute endpoint."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app

_CLUSTER_ID = "unit-rds-data-api-cluster-1"
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_CLUSTER_ARN = f"arn:aws:rds:{_REGION}:{_ACCOUNT}:cluster:{_CLUSTER_ID}"
_SECRET_ARN = f"arn:aws:secretsmanager:{_REGION}:{_ACCOUNT}:secret:rds-secret"
_RDS_TARGET = "AmazonRDSv19"


@pytest.fixture()
def client() -> TestClient:
    app = create_rds_app()
    return TestClient(app)


def _create_cluster(client: TestClient, cluster_id: str = _CLUSTER_ID) -> dict:
    resp = client.post(
        "/",
        headers={"X-Amz-Target": f"{_RDS_TARGET}.CreateDBCluster"},
        json={"DBClusterIdentifier": cluster_id, "Engine": "aurora-postgresql"},
    )
    return resp.json()


def _execute_sql(
    client: TestClient,
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
    resp = client.post("/execute", json=payload)
    return resp.json()


class TestRdsDataApiExecute:
    def test_create_table_returns_zero_records(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        expected_records: list = []

        # Act
        actual_result = _execute_sql(
            client,
            _CLUSTER_ARN,
            "CREATE TABLE unit_items (id INTEGER PRIMARY KEY, name TEXT)",
        )

        # Assert
        actual_records = actual_result.get("records", [])
        assert (
            actual_records == expected_records
        ), f"Expected {expected_records!r} but got {actual_records!r}"

    def test_insert_and_select_returns_row(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(
            client,
            _CLUSTER_ARN,
            "CREATE TABLE unit_items (id INTEGER PRIMARY KEY, name TEXT)",
        )
        _execute_sql(
            client,
            _CLUSTER_ARN,
            "INSERT INTO unit_items VALUES (1, 'hello')",
        )
        expected_record_count = 1

        # Act
        actual_result = _execute_sql(
            client,
            _CLUSTER_ARN,
            "SELECT id, name FROM unit_items",
        )

        # Assert
        actual_records = actual_result.get("records", [])
        actual_record_count = len(actual_records)
        assert (
            actual_record_count == expected_record_count
        ), f"Expected {expected_record_count!r} records but got {actual_record_count!r}"

    def test_select_maps_integer_to_long_value(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(
            client,
            _CLUSTER_ARN,
            "CREATE TABLE unit_nums (val INTEGER)",
        )
        _execute_sql(client, _CLUSTER_ARN, "INSERT INTO unit_nums VALUES (42)")
        expected_field = {"longValue": 42}

        # Act
        actual_result = _execute_sql(client, _CLUSTER_ARN, "SELECT val FROM unit_nums")

        # Assert
        actual_field = actual_result["records"][0][0]
        assert (
            actual_field == expected_field
        ), f"Expected {expected_field!r} but got {actual_field!r}"

    def test_select_maps_string_to_string_value(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(client, _CLUSTER_ARN, "CREATE TABLE unit_strs (val TEXT)")
        _execute_sql(client, _CLUSTER_ARN, "INSERT INTO unit_strs VALUES ('world')")
        expected_field = {"stringValue": "world"}

        # Act
        actual_result = _execute_sql(client, _CLUSTER_ARN, "SELECT val FROM unit_strs")

        # Assert
        actual_field = actual_result["records"][0][0]
        assert (
            actual_field == expected_field
        ), f"Expected {expected_field!r} but got {actual_field!r}"

    def test_select_null_maps_to_is_null(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(client, _CLUSTER_ARN, "CREATE TABLE unit_nulls (val TEXT)")
        _execute_sql(client, _CLUSTER_ARN, "INSERT INTO unit_nulls VALUES (NULL)")
        expected_field = {"isNull": True}

        # Act
        actual_result = _execute_sql(client, _CLUSTER_ARN, "SELECT val FROM unit_nulls")

        # Assert
        actual_field = actual_result["records"][0][0]
        assert (
            actual_field == expected_field
        ), f"Expected {expected_field!r} but got {actual_field!r}"

    def test_unknown_cluster_arn_returns_400(self, client: TestClient) -> None:
        # Arrange
        unknown_arn = "arn:aws:rds:us-east-1:000000000000:cluster:no-such-cluster"
        expected_status = 400

        # Act
        resp = client.post(
            "/execute",
            json={"resourceArn": unknown_arn, "secretArn": _SECRET_ARN, "sql": "SELECT 1"},
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_invalid_sql_returns_400(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        expected_status = 400

        # Act
        resp = client.post(
            "/execute",
            json={
                "resourceArn": _CLUSTER_ARN,
                "secretArn": _SECRET_ARN,
                "sql": "THIS IS NOT SQL !!!",
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_parameterised_query_binds_correctly(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(client, _CLUSTER_ARN, "CREATE TABLE unit_params (id INTEGER, label TEXT)")
        _execute_sql(client, _CLUSTER_ARN, "INSERT INTO unit_params VALUES (10, 'alpha')")
        expected_record_count = 1
        parameters = [{"name": "p1", "value": {"longValue": 10}}]

        # Act
        actual_result = _execute_sql(
            client,
            _CLUSTER_ARN,
            "SELECT id, label FROM unit_params WHERE id = ?",
            parameters=parameters,
        )

        # Assert
        actual_record_count = len(actual_result.get("records", []))
        assert (
            actual_record_count == expected_record_count
        ), f"Expected {expected_record_count!r} records but got {actual_record_count!r}"

    def test_insert_returns_number_of_records_updated(self, client: TestClient) -> None:
        # Arrange
        _create_cluster(client)
        _execute_sql(client, _CLUSTER_ARN, "CREATE TABLE unit_upd (id INTEGER, val TEXT)")
        _execute_sql(client, _CLUSTER_ARN, "INSERT INTO unit_upd VALUES (1, 'a')")
        expected_updated = 1

        # Act
        actual_result = _execute_sql(
            client, _CLUSTER_ARN, "UPDATE unit_upd SET val = 'b' WHERE id = 1"
        )

        # Assert
        actual_updated = actual_result.get("numberOfRecordsUpdated", 0)
        assert (
            actual_updated == expected_updated
        ), f"Expected {expected_updated!r} records updated but got {actual_updated!r}"
