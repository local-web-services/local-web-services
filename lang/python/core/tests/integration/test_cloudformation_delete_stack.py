"""Integration tests: CloudFormation DeleteStack wire protocol."""

from __future__ import annotations

from starlette.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app

from ._helpers import cfn_post


class TestDeleteStack:
    def test_delete_stack_removes_it_from_describe(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Act
        status, _ = cfn_post(cfn_client, "DeleteStack", StackName="my-stack")

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
        describe_status, describe_body = cfn_post(
            cfn_client, "DescribeStacks", StackName="my-stack"
        )
        assert describe_status == 400
        assert "StackNotFoundException" in describe_body

    def test_delete_nonexistent_stack_is_noop(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, _ = cfn_post(cfn_client, "DeleteStack", StackName="ghost-stack")

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
