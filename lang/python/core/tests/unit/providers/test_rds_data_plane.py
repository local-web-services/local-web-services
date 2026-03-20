"""Tests for RDS per-resource container wiring."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

from fastapi.testclient import TestClient

from lws.providers.rds.routes import create_rds_app


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


class TestRdsDataPlaneEndpoint:
    def test_postgres_with_container_manager_uses_real_endpoint(self) -> None:
        # Arrange
        expected_address = "localhost"
        expected_port = 15432
        fake_cm = AsyncMock()
        fake_cm.start_container.return_value = "localhost:15432"
        app = create_rds_app(postgres_container_manager=fake_cm)
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": "test-pg",
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )

        # Assert
        actual_endpoint = result["DBInstance"]["Endpoint"]
        actual_address = actual_endpoint["Address"]
        actual_port = actual_endpoint["Port"]
        assert actual_address == expected_address, f"Expected {expected_address!r} but got {actual_address!r}"
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"
        fake_cm.start_container.assert_called_once_with("test-pg")

    def test_mysql_with_container_manager_uses_real_endpoint(self) -> None:
        # Arrange
        expected_address = "localhost"
        expected_port = 13306
        fake_cm = AsyncMock()
        fake_cm.start_container.return_value = "localhost:13306"
        app = create_rds_app(mysql_container_manager=fake_cm)
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": "test-mysql",
                "Engine": "mysql",
                "MasterUsername": "admin",
            },
        )

        # Assert
        actual_endpoint = result["DBInstance"]["Endpoint"]
        actual_address = actual_endpoint["Address"]
        actual_port = actual_endpoint["Port"]
        assert actual_address == expected_address, f"Expected {expected_address!r} but got {actual_address!r}"
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"
        fake_cm.start_container.assert_called_once_with("test-mysql")

    def test_without_container_manager_uses_synthetic_endpoint(self) -> None:
        # Arrange
        expected_suffix = "rds.amazonaws.com"
        expected_port = 5432
        app = create_rds_app()
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": "test-pg",
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )

        # Assert
        actual_endpoint = result["DBInstance"]["Endpoint"]
        actual_address = actual_endpoint["Address"]
        actual_port = actual_endpoint["Port"]
        assert expected_suffix in actual_address, f"Expected {expected_suffix!r} to be in {actual_address!r}"
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"

    def test_cluster_with_postgres_container_manager_uses_real_endpoint(self) -> None:
        # Arrange
        expected_host = "localhost"
        expected_port = 15432
        fake_cm = AsyncMock()
        fake_cm.start_container.return_value = "localhost:15432"
        app = create_rds_app(postgres_container_manager=fake_cm)
        client = TestClient(app)

        # Act
        result = _post(
            client,
            "CreateDBCluster",
            {
                "DBClusterIdentifier": "test-pg-cluster",
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )

        # Assert
        actual_endpoint = result["DBCluster"]["Endpoint"]
        actual_port = result["DBCluster"]["Port"]
        assert actual_endpoint == expected_host, f"Expected {expected_host!r} but got {actual_endpoint!r}"
        assert actual_port == expected_port, f"Expected {expected_port!r} but got {actual_port!r}"
        fake_cm.start_container.assert_called_once_with("test-pg-cluster")

    def test_delete_standalone_instance_stops_container(self) -> None:
        # Arrange
        fake_cm = AsyncMock()
        fake_cm.start_container.return_value = "localhost:15432"
        app = create_rds_app(postgres_container_manager=fake_cm)
        client = TestClient(app)
        _post(
            client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": "test-pg",
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )

        # Act
        _post(client, "DeleteDBInstance", {"DBInstanceIdentifier": "test-pg"})

        # Assert
        fake_cm.stop_container.assert_called_once_with("test-pg")

    def test_delete_cluster_stops_container(self) -> None:
        # Arrange
        fake_cm = AsyncMock()
        fake_cm.start_container.return_value = "localhost:15432"
        app = create_rds_app(postgres_container_manager=fake_cm)
        client = TestClient(app)
        _post(
            client,
            "CreateDBCluster",
            {
                "DBClusterIdentifier": "test-pg-cluster",
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )

        # Act
        _post(client, "DeleteDBCluster", {"DBClusterIdentifier": "test-pg-cluster"})

        # Assert
        fake_cm.stop_container.assert_called_once_with("test-pg-cluster")
