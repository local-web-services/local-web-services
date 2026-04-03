"""Tests for CloudFormation CreateStack operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app


def _client() -> TestClient:
    return TestClient(create_cloudformation_app())


class TestCreateStack:
    def test_create_stack_succeeds(self) -> None:
        # Arrange
        client = _client()
        stack_name = "test-stack"
        expected_status = 200

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "CreateStack",
                "StackName": stack_name,
                "TemplateBody": "{}",
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert "StackId" in resp.text, "Expected response to contain StackId"

    def test_create_duplicate_stack_returns_already_exists(self) -> None:
        # Arrange
        client = _client()
        stack_name = "dup-stack"
        expected_error_code = "AlreadyExistsException"
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
                "Action": "CreateStack",
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

    def test_create_without_stack_name_returns_validation_error(self) -> None:
        # Arrange
        client = _client()
        expected_error_code = "ValidationError"

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "CreateStack",
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
