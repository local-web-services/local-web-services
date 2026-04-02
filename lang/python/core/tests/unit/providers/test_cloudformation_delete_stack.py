"""Tests for CloudFormation DeleteStack operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app


def _client() -> TestClient:
    return TestClient(create_cloudformation_app())


class TestDeleteStack:
    def test_delete_existing_stack_succeeds(self) -> None:
        # Arrange
        client = _client()
        stack_name = "delete-me"
        expected_status = 200
        client.post(
            "/",
            data={
                "Action": "CreateStack",
                "StackName": stack_name,
                "TemplateBody": "{}",
            },
        )

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "DeleteStack",
                "StackName": stack_name,
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_delete_nonexistent_stack_is_idempotent(self) -> None:
        # Arrange
        client = _client()
        stack_name = "never-existed"
        expected_status = 200

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "DeleteStack",
                "StackName": stack_name,
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
