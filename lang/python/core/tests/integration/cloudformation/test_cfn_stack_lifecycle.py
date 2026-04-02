"""Integration tests for CloudFormation stack lifecycle and per-account isolation."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import pytest
from starlette.testclient import TestClient

from lws.providers.cloudformation.routes import create_cloudformation_app

_NS = {"cfn": "http://cloudformation.amazonaws.com/doc/2010-05-15/"}


def _post_form(client: TestClient, data: dict, headers: dict | None = None) -> tuple[int, str]:
    resp = client.post("/", data=data, headers=headers or {})
    return resp.status_code, resp.text


@pytest.fixture
def cfn_client() -> TestClient:
    app = create_cloudformation_app()
    return TestClient(app, raise_server_exceptions=False)


class TestCfnStackLifecycle:
    def test_create_describe_update_delete_lifecycle(self, cfn_client: TestClient) -> None:
        # Arrange
        expected_stack_name = "inttest-lifecycle-stack"
        template_v1 = '{"AWSTemplateFormatVersion":"2010-09-09"}'
        template_v2 = '{"AWSTemplateFormatVersion":"2010-09-09","Description":"v2"}'

        # Act — create
        create_status, create_body = _post_form(
            cfn_client,
            {
                "Action": "CreateStack",
                "StackName": expected_stack_name,
                "TemplateBody": template_v1,
            },
        )

        # Assert — create
        assert create_status == 200, f"CreateStack failed with status {create_status}"
        create_root = ET.fromstring(create_body)
        actual_stack_id = create_root.findtext(".//cfn:StackId", namespaces=_NS)
        assert actual_stack_id is not None, "CreateStack should return a StackId"
        assert (
            expected_stack_name in actual_stack_id
        ), f"StackId should contain stack name, got {actual_stack_id}"

        # Act — describe after create
        describe_status, describe_body = _post_form(
            cfn_client,
            {"Action": "DescribeStacks", "StackName": expected_stack_name},
        )

        # Assert — describe after create
        assert describe_status == 200, f"DescribeStacks failed with status {describe_status}"
        describe_root = ET.fromstring(describe_body)
        actual_status = describe_root.findtext(".//cfn:StackStatus", namespaces=_NS)
        expected_create_status = "CREATE_COMPLETE"
        assert (
            actual_status == expected_create_status
        ), f"Expected stack status {expected_create_status}, got {actual_status}"

        # Act — update
        update_status, _ = _post_form(
            cfn_client,
            {
                "Action": "UpdateStack",
                "StackName": expected_stack_name,
                "TemplateBody": template_v2,
            },
        )

        # Assert — update
        assert update_status == 200, f"UpdateStack failed with status {update_status}"

        # Act — describe after update
        _, describe_after_update_body = _post_form(
            cfn_client,
            {"Action": "DescribeStacks", "StackName": expected_stack_name},
        )

        # Assert — describe after update
        update_root = ET.fromstring(describe_after_update_body)
        actual_updated_status = update_root.findtext(".//cfn:StackStatus", namespaces=_NS)
        expected_updated_status = "UPDATE_COMPLETE"
        assert (
            actual_updated_status == expected_updated_status
        ), f"Expected stack status {expected_updated_status}, got {actual_updated_status}"

        # Act — delete
        delete_status, _ = _post_form(
            cfn_client,
            {"Action": "DeleteStack", "StackName": expected_stack_name},
        )

        # Assert — delete
        assert delete_status == 200, f"DeleteStack failed with status {delete_status}"

        # Act — describe after delete
        describe_deleted_status, describe_deleted_body = _post_form(
            cfn_client,
            {"Action": "DescribeStacks", "StackName": expected_stack_name},
        )

        # Assert — describe after delete should fail
        expected_deleted_status = 400
        assert (
            describe_deleted_status == expected_deleted_status
        ), f"Expected {expected_deleted_status} for deleted stack, got {describe_deleted_status}"

    def test_per_account_isolation(self, cfn_client: TestClient) -> None:
        # Arrange
        token_account_a = "lws-acct-111111111111-test-uuid-a"
        token_account_b = "lws-acct-222222222222-test-uuid-b"
        expected_stack_name = "isolation-test-stack"

        # Act — create stack in account A
        create_status, _ = _post_form(
            cfn_client,
            {
                "Action": "CreateStack",
                "StackName": expected_stack_name,
                "TemplateBody": "{}",
            },
            headers={"X-Amz-Security-Token": token_account_a},
        )

        # Assert — create succeeds
        assert create_status == 200, f"CreateStack in account A failed: {create_status}"

        # Act — describe from account B (should not see the stack)
        describe_b_status, describe_b_body = _post_form(
            cfn_client,
            {"Action": "DescribeStacks", "StackName": expected_stack_name},
            headers={"X-Amz-Security-Token": token_account_b},
        )

        # Assert — account B should not find account A's stack
        expected_not_found_status = 400
        assert describe_b_status == expected_not_found_status, (
            f"Account B should not see account A's stack, "
            f"expected {expected_not_found_status}, got {describe_b_status}"
        )

        # Act — describe from account A (should see the stack)
        describe_a_status, describe_a_body = _post_form(
            cfn_client,
            {"Action": "DescribeStacks", "StackName": expected_stack_name},
            headers={"X-Amz-Security-Token": token_account_a},
        )

        # Assert — account A should find its own stack
        assert (
            describe_a_status == 200
        ), f"Account A should see its own stack, got status {describe_a_status}"
        describe_a_root = ET.fromstring(describe_a_body)
        actual_stack_name = describe_a_root.findtext(".//cfn:StackName", namespaces=_NS)
        assert (
            actual_stack_name == expected_stack_name
        ), f"Expected stack name {expected_stack_name}, got {actual_stack_name}"
