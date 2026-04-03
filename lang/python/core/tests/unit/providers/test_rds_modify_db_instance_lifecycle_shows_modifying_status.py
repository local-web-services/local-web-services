"""Unit tests: RDS ModifyDBInstance lifecycle — MODIFYING status during dwell."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers.rds.routes import create_rds_app


def _post(client: TestClient, action: str, body: dict) -> dict:
    resp = client.post(
        "/",
        content=json.dumps(body),
        headers={"x-amz-target": action},
    )
    return resp.json()


def _create_instance(client: TestClient, instance_id: str) -> None:
    _post(
        client,
        "CreateDBInstance",
        {
            "DBInstanceIdentifier": instance_id,
            "Engine": "postgres",
            "MasterUsername": "admin",
        },
    )


def _make_lifecycle_client(create_dwell_ms: int, modify_dwell_ms: int) -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = create_dwell_ms
    lc.modify_dwell_ms = modify_dwell_ms
    app = create_rds_app(lifecycle=lc)
    return TestClient(app)


@pytest.fixture()
def modifying_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=5000)


@pytest.fixture()
def instant_modify_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestModifyDbInstanceLifecycle:
    def test_modify_instance_shows_modifying_status_during_dwell(
        self, modifying_client: TestClient
    ) -> None:
        # Arrange
        instance_id = "modify-lc-instance"
        _create_instance(modifying_client, instance_id)
        expected_status = "modifying"

        # Act
        _post(
            modifying_client,
            "ModifyDBInstance",
            {"DBInstanceIdentifier": instance_id, "DBInstanceClass": "db.r5.large"},
        )
        result = _post(
            modifying_client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        actual_status = result["DBInstances"][0]["DBInstanceStatus"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_instance_shows_available_after_zero_dwell_modify(
        self, instant_modify_client: TestClient
    ) -> None:
        # Arrange
        instance_id = "modify-instant-instance"
        _create_instance(instant_modify_client, instance_id)
        expected_status = "available"

        # Act
        _post(
            instant_modify_client,
            "ModifyDBInstance",
            {"DBInstanceIdentifier": instance_id, "DBInstanceClass": "db.r5.large"},
        )
        result = _post(
            instant_modify_client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        actual_status = result["DBInstances"][0]["DBInstanceStatus"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
