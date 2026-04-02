"""Tests for CloudFormation ListStacks operation."""

from __future__ import annotations

from fastapi.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app


def _client() -> TestClient:
    return TestClient(create_cloudformation_app())


class TestListStacks:
    def test_list_returns_created_stacks(self) -> None:
        # Arrange
        client = _client()
        stack_name = "listed-stack"
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
                "Action": "ListStacks",
            },
        )

        # Assert
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        assert stack_name in resp.text, f"Expected {stack_name!r} in response body"
