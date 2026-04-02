"""Tests for CloudFormation DescribeStacks operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app


def _client() -> TestClient:
    return TestClient(create_cloudformation_app())


class TestDescribeStacks:
    def test_describe_specific_stack_returns_details(self) -> None:
        # Arrange
        client = _client()
        stack_name = "describe-me"
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
                "Action": "DescribeStacks",
                "StackName": stack_name,
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert stack_name in resp.text, f"Expected {stack_name!r} in response body"

    def test_describe_nonexistent_stack_returns_not_found(self) -> None:
        # Arrange
        client = _client()
        stack_name = "no-such-stack"
        expected_error_code = "StackNotFoundException"

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "DescribeStacks",
                "StackName": stack_name,
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

    def test_describe_all_stacks_returns_all(self) -> None:
        # Arrange
        client = _client()
        stack_name_a = "stack-alpha"
        stack_name_b = "stack-bravo"
        expected_status = 200
        client.post(
            "/",
            data={
                "Action": "CreateStack",
                "StackName": stack_name_a,
                "TemplateBody": "{}",
            },
        )
        client.post(
            "/",
            data={
                "Action": "CreateStack",
                "StackName": stack_name_b,
                "TemplateBody": "{}",
            },
        )

        # Act
        resp = client.post(
            "/",
            data={
                "Action": "DescribeStacks",
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert stack_name_a in resp.text, f"Expected {stack_name_a!r} in response body"
        assert stack_name_b in resp.text, f"Expected {stack_name_b!r} in response body"
