"""Integration tests for SSM per-account isolation."""

from __future__ import annotations

import json

import pytest
from starlette.testclient import TestClient

from lws.providers.ssm.routes import create_ssm_app

_TARGET_PREFIX = "AmazonSSM"


def _post_json(
    client: TestClient, action: str, body: dict, headers: dict | None = None
) -> tuple[int, dict]:
    all_headers = {
        "Content-Type": "application/x-amz-json-1.1",
        "X-Amz-Target": f"{_TARGET_PREFIX}.{action}",
    }
    if headers:
        all_headers.update(headers)
    resp = client.post("/", headers=all_headers, content=json.dumps(body))
    return resp.status_code, resp.json()


@pytest.fixture
def ssm_client() -> TestClient:
    app, _ = create_ssm_app()
    return TestClient(app, raise_server_exceptions=False)


class TestSsmPerAccountIsolation:
    def test_parameter_in_account_a_not_visible_in_account_b(self, ssm_client: TestClient) -> None:
        # Arrange
        token_account_a = "lws-acct-111111111111-test-uuid-a"
        token_account_b = "lws-acct-222222222222-test-uuid-b"
        expected_param_name = "/inttest/account-a-only"
        expected_param_value = "secret-a"

        # Act — put parameter in account A
        put_status, _ = _post_json(
            ssm_client,
            "PutParameter",
            {
                "Name": expected_param_name,
                "Value": expected_param_value,
                "Type": "String",
            },
            headers={"X-Amz-Security-Token": token_account_a},
        )

        # Assert — put succeeds
        assert put_status == 200, f"PutParameter in account A failed: {put_status}"

        # Act — get parameter from account B
        get_b_status, get_b_body = _post_json(
            ssm_client,
            "GetParameter",
            {"Name": expected_param_name},
            headers={"X-Amz-Security-Token": token_account_b},
        )

        # Assert — account B should not find account A's parameter
        expected_error_type = "ParameterNotFound"
        actual_error_type = get_b_body.get("__type", "")
        assert (
            get_b_status == 400
        ), f"Account B should get 400 for account A's parameter, got {get_b_status}"
        assert (
            actual_error_type == expected_error_type
        ), f"Expected error type {expected_error_type}, got {actual_error_type}"

    def test_parameter_in_account_a_visible_with_account_a_token(
        self, ssm_client: TestClient
    ) -> None:
        # Arrange
        token_account_a = "lws-acct-333333333333-test-uuid-a"
        expected_param_name = "/inttest/visible-in-a"
        expected_param_value = "value-for-a"

        # Act — put parameter in account A
        put_status, _ = _post_json(
            ssm_client,
            "PutParameter",
            {
                "Name": expected_param_name,
                "Value": expected_param_value,
                "Type": "String",
            },
            headers={"X-Amz-Security-Token": token_account_a},
        )

        # Assert — put succeeds
        assert put_status == 200, f"PutParameter failed: {put_status}"

        # Act — get parameter with same account A token
        get_a_status, get_a_body = _post_json(
            ssm_client,
            "GetParameter",
            {"Name": expected_param_name},
            headers={"X-Amz-Security-Token": token_account_a},
        )

        # Assert — account A should see its own parameter
        assert (
            get_a_status == 200
        ), f"Account A should see its own parameter, got status {get_a_status}"
        actual_param_value = get_a_body.get("Parameter", {}).get("Value", "")
        assert (
            actual_param_value == expected_param_value
        ), f"Expected value {expected_param_value}, got {actual_param_value}"
