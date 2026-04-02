"""Integration tests: CloudFormation UpdateStack wire protocol."""

from __future__ import annotations

from starlette.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app

from ._helpers import cfn_post


class TestUpdateStack:
    def test_update_stack_sets_update_complete(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Act
        status, body = cfn_post(cfn_client, "UpdateStack", StackName="my-stack", TemplateBody="{}")

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
        _, describe_body = cfn_post(cfn_client, "DescribeStacks", StackName="my-stack")
        assert "UPDATE_COMPLETE" in describe_body

    def test_update_nonexistent_stack_returns_not_found(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, body = cfn_post(cfn_client, "UpdateStack", StackName="missing-stack")

        # Assert
        actual_status = status
        expected_status = 400
        assert actual_status == expected_status
        assert "StackNotFoundException" in body
