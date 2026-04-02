"""Integration tests: CloudFormation CreateStack wire protocol."""

from __future__ import annotations

from starlette.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app

from ._helpers import cfn_post


class TestCreateStack:
    def test_create_stack_returns_stack_id(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, body = cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
        assert "my-stack" in body
        assert "StackId" in body

    def test_duplicate_stack_returns_already_exists(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Act
        status, body = cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Assert
        actual_status = status
        expected_status = 400
        assert actual_status == expected_status
        assert "AlreadyExistsException" in body
