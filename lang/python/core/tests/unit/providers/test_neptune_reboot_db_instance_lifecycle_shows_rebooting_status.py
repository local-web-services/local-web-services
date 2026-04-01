"""Unit tests: Neptune RebootDBInstance lifecycle — REBOOTING status during dwell."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers.neptune.routes import create_neptune_app

_TARGET_PREFIX = "AmazonNeptune."


def _post(client: TestClient, action: str, body: dict) -> dict:
    resp = client.post(
        "/",
        content=json.dumps(body),
        headers={"x-amz-target": f"{_TARGET_PREFIX}{action}"},
    )
    return resp.json()


def _setup_cluster_and_instance(client: TestClient, cluster_id: str, instance_id: str) -> None:
    _post(client, "CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})
    _post(
        client,
        "CreateDBInstance",
        {
            "DBInstanceIdentifier": instance_id,
            "DBClusterIdentifier": cluster_id,
            "DBInstanceClass": "db.r5.large",
            "Engine": "neptune",
        },
    )


def _make_lifecycle_client(create_dwell_ms: int, modify_dwell_ms: int) -> TestClient:
    lc = ResourceLifecycleConfig()
    lc.enabled = True
    lc.create_dwell_ms = create_dwell_ms
    lc.modify_dwell_ms = modify_dwell_ms
    app, _ = create_neptune_app(lifecycle=lc)
    return TestClient(app)


@pytest.fixture()
def rebooting_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=5000)


@pytest.fixture()
def instant_reboot_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestRebootDbInstanceLifecycle:
    def test_reboot_instance_shows_rebooting_status_during_dwell(
        self, rebooting_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "reboot-lc-cluster"
        instance_id = "reboot-lc-instance"
        _setup_cluster_and_instance(rebooting_client, cluster_id, instance_id)
        expected_status = "rebooting"

        # Act
        _post(rebooting_client, "RebootDBInstance", {"DBInstanceIdentifier": instance_id})
        result = _post(
            rebooting_client, "DescribeDBInstances", {"DBInstanceIdentifier": instance_id}
        )

        # Assert
        actual_status = result["DBInstances"][0]["DBInstanceStatus"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_describe_instance_shows_available_after_zero_dwell_reboot(
        self, instant_reboot_client: TestClient
    ) -> None:
        # Arrange
        cluster_id = "reboot-instant-cluster"
        instance_id = "reboot-instant-instance"
        _setup_cluster_and_instance(instant_reboot_client, cluster_id, instance_id)
        expected_status = "available"

        # Act
        _post(instant_reboot_client, "RebootDBInstance", {"DBInstanceIdentifier": instance_id})
        result = _post(
            instant_reboot_client, "DescribeDBInstances", {"DBInstanceIdentifier": instance_id}
        )

        # Assert
        actual_status = result["DBInstances"][0]["DBInstanceStatus"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
