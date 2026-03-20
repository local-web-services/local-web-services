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
        assert len(versions) > 0, f"Expected {len(versions)!r} > {0!r}"
        for v in versions:
            actual_engine = v["Engine"]
            assert actual_engine == expected_engine, f"Expected {expected_engine!r} but got {actual_engine!r}"

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
        assert len(versions) > 0, f"Expected {len(versions)!r} > {0!r}"
        for v in versions:
            actual_engine = v["Engine"]
            assert actual_engine == expected_engine, f"Expected {expected_engine!r} but got {actual_engine!r}"

    def test_describe_all_engine_versions(self, client: TestClient) -> None:
        # Arrange — no engine filter

        # Act
        result = _post(client, "DescribeDBEngineVersions", {})

        # Assert
        versions = result["DBEngineVersions"]
        engines = {v["Engine"] for v in versions}
        assert "postgres" in engines, f'Expected {"postgres"!r} to be in {engines!r}'
        assert "mysql" in engines, f'Expected {"mysql"!r} to be in {engines!r}'

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
        assert len(result["DBEngineVersions"]) == expected_count, f'Expected {expected_count!r} but got {len(result["DBEngineVersions"])!r}'

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
        assert "Engine" in version, f'Expected {"Engine"!r} to be in {version!r}'
        assert "EngineVersion" in version, f'Expected {"EngineVersion"!r} to be in {version!r}'
        assert "DBParameterGroupFamily" in version, f'Expected {"DBParameterGroupFamily"!r} to be in {version!r}'
        assert "DBEngineDescription" in version, f'Expected {"DBEngineDescription"!r} to be in {version!r}'
        assert "DBEngineVersionDescription" in version, f'Expected {"DBEngineVersionDescription"!r} to be in {version!r}'
