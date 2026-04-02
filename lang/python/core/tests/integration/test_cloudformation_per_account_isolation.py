"""Integration tests: CloudFormation per-account state isolation."""

from __future__ import annotations

from starlette.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app

from ._helpers import cfn_post

_TOKEN_A = "lws-acct-111111111111-test-uuid"
_TOKEN_B = "lws-acct-222222222222-test-uuid"


def _post_with_token(
    cfn_client: TestClient, action: str, token: str, **params: str
) -> tuple[int, str]:
    resp = cfn_client.post(
        "/",
        data={"Action": action, **params},
        headers={"X-Amz-Security-Token": token},
    )
    return resp.status_code, resp.text


class TestPerAccountIsolation:
    def test_stack_in_account_a_not_visible_in_account_b(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        _post_with_token(cfn_client, "CreateStack", _TOKEN_A, StackName="my-stack")

        # Act
        status, body = _post_with_token(
            cfn_client, "DescribeStacks", _TOKEN_B, StackName="my-stack"
        )

        # Assert
        actual_status = status
        expected_status = 400
        assert actual_status == expected_status
        assert "StackNotFoundException" in body

    def test_stack_in_account_a_visible_within_same_account(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        _post_with_token(cfn_client, "CreateStack", _TOKEN_A, StackName="my-stack")

        # Act
        status, body = _post_with_token(
            cfn_client, "DescribeStacks", _TOKEN_A, StackName="my-stack"
        )

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
        assert "my-stack" in body

    def test_no_token_uses_default_account(self) -> None:
        # Arrange
        app = create_cloudformation_app()
        cfn_client = TestClient(app, raise_server_exceptions=False)
        cfn_post(cfn_client, "CreateStack", StackName="my-stack")

        # Act
        status, body = cfn_post(cfn_client, "DescribeStacks", StackName="my-stack")

        # Assert
        actual_status = status
        expected_status = 200
        assert actual_status == expected_status
        assert "my-stack" in body
