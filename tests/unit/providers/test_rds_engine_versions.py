"""Tests for lws.providers.rds.routes -- DescribeDBEngineVersions."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app


@pytest.fixture()
def client() -> TestClient:
    app = create_rds_app()
    return TestClient(app)


def _post(client: TestClient, action: str, body: dict | None = None) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"AmazonRDSv19.{action}",
        },
        content=json.dumps(body or {}),
    )
    return resp.json()


class TestDescribeDBEngineVersions:
    def test_describe_postgres_versions(self, client: TestClient) -> None:
        # Arrange
        expected_engine = "postgres"

        # Act
        result = _post(
            client,
            "DescribeDBEngineVersions",
            {"Engine": expected_engine},
        )

        # Assert
        versions = result["DBEngineVersions"]
        assert len(versions) > 0
        for v in versions:
            actual_engine = v["Engine"]
            assert actual_engine == expected_engine

    def test_describe_mysql_versions(self, client: TestClient) -> None:
        # Arrange
        expected_engine = "mysql"

        # Act
        result = _post(
            client,
            "DescribeDBEngineVersions",
            {"Engine": expected_engine},
        )

        # Assert
        versions = result["DBEngineVersions"]
        assert len(versions) > 0
        for v in versions:
            actual_engine = v["Engine"]
            assert actual_engine == expected_engine

    def test_describe_all_engine_versions(self, client: TestClient) -> None:
        # Arrange — no engine filter

        # Act
        result = _post(client, "DescribeDBEngineVersions", {})

        # Assert
        versions = result["DBEngineVersions"]
        engines = {v["Engine"] for v in versions}
        assert "postgres" in engines
        assert "mysql" in engines

    def test_describe_unknown_engine_returns_empty(self, client: TestClient) -> None:
        # Arrange
        expected_count = 0

        # Act
        result = _post(
            client,
            "DescribeDBEngineVersions",
            {"Engine": "oracle"},
        )

        # Assert
        assert len(result["DBEngineVersions"]) == expected_count

    def test_version_entry_has_required_fields(self, client: TestClient) -> None:
        # Arrange
        # pass

        # Act
        result = _post(
            client,
            "DescribeDBEngineVersions",
            {"Engine": "postgres"},
        )

        # Assert
        version = result["DBEngineVersions"][0]
        assert "Engine" in version
        assert "EngineVersion" in version
        assert "DBParameterGroupFamily" in version
        assert "DBEngineDescription" in version
        assert "DBEngineVersionDescription" in version
