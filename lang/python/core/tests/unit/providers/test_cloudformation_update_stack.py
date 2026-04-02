"""Tests for CloudFormation UpdateStack operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app


def _client() -> TestClient:
    return TestClient(create_cloudformation_app())


class TestUpdateStack:
    def test_update_existing_stack_succeeds(self) -> None:
        # Arrange
        client = _client()
        stack_name = "update-me"
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
                "Action": "UpdateStack",
                "StackName": stack_name,
                "TemplateBody": '{"updated": true}',
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert "StackId" in resp.text, "Expected response to contain StackId"

    def test_update_nonexistent_stack_returns_not_found(self) -> None:
        # Arrange
        client = _client()
        stack_name = "no-such-stack"
        expected_error_code = "StackNotFoundException"

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "UpdateStack",
                "StackName": stack_name,
                "TemplateBody": "{}",
            },
        )

        # Assert
        expected_status = 400
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert (
            expected_error_code in resp.text
        ), f"Expected {expected_error_code!r} in response body"
