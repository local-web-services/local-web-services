"""Unit tests: RDS DescribeDBInstances reflects lifecycle tracker state overlay."""

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
def creating_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=5000, modify_dwell_ms=0)


@pytest.fixture()
def available_client() -> TestClient:
    return _make_lifecycle_client(create_dwell_ms=0, modify_dwell_ms=0)


class TestDescribeDbInstancesShowsTrackerState:
    def test_describe_instance_blocked_during_create_dwell(
        self, creating_client: TestClient
    ) -> None:
        # Arrange
        instance_id = "describe-creating-instance"
        _post(
            creating_client,
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": instance_id,
                "Engine": "postgres",
                "MasterUsername": "admin",
            },
        )
        expected_fault = "InvalidDBInstanceStateFault"

        # Act
        result = _post(
            creating_client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        actual_fault = result["__type"]
        assert (
            actual_fault == expected_fault
        ), f"Expected {expected_fault!r} but got {actual_fault!r}"

    def test_describe_instance_shows_available_after_zero_create_dwell(
        self, available_client: TestClient
    ) -> None:
        # Arrange
        instance_id = "describe-available-instance"
        _create_instance(available_client, instance_id)
        expected_status = "available"

        # Act
        result = _post(
            available_client,
            "DescribeDBInstances",
            {"DBInstanceIdentifier": instance_id},
        )

        # Assert
        actual_status = result["DBInstances"][0]["DBInstanceStatus"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
