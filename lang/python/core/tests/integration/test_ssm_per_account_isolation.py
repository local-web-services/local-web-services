"""Integration tests: SSM per-account state isolation."""

from __future__ import annotations

import json

from starlette.testclient import TestClient

from lws.providers._shared.per_account_state import PerAccountStateRegistry
from lws.providers.ssm._ssm_state import _SsmState
from lws.providers.ssm.routes import create_ssm_app

_TOKEN_A = "lws-acct-111111111111-test-uuid"
_TOKEN_B = "lws-acct-222222222222-test-uuid"


def _ssm_post(
    ssm_client: TestClient, action: str, body: dict, token: str | None = None
) -> tuple[int, dict]:
    headers: dict = {
        "Content-Type": "application/x-amz-json-1.1",
        "X-Amz-Target": f"AmazonSSM.{action}",
    }
    if token:
        headers["X-Amz-Security-Token"] = token
    resp = ssm_client.post("/", headers=headers, content=json.dumps(body))
    return resp.status_code, resp.json()


class TestSsmPerAccountIsolation:
    def test_parameter_in_account_a_not_visible_in_account_b(self) -> None:
        # Arrange
        registry = PerAccountStateRegistry(_SsmState)
        app, _ = create_ssm_app(registry=registry)
        ssm_client = TestClient(app, raise_server_exceptions=False)
        _ssm_post(ssm_client, "PutParameter", {"Name": "/my/param", "Value": "val-a"}, _TOKEN_A)

        # Act
        actual_status, actual_body = _ssm_post(
            ssm_client, "GetParameter", {"Name": "/my/param"}, _TOKEN_B
        )

        # Assert
        expected_status = 400
        assert actual_status == expected_status
        assert "ParameterNotFound" in str(actual_body)

    def test_parameter_in_account_a_visible_within_same_account(self) -> None:
        # Arrange
        registry = PerAccountStateRegistry(_SsmState)
        app, _ = create_ssm_app(registry=registry)
        ssm_client = TestClient(app, raise_server_exceptions=False)
        _ssm_post(ssm_client, "PutParameter", {"Name": "/my/param", "Value": "val-a"}, _TOKEN_A)

        # Act
        actual_status, actual_body = _ssm_post(
            ssm_client, "GetParameter", {"Name": "/my/param"}, _TOKEN_A
        )

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        assert actual_body["Parameter"]["Value"] == "val-a"

    def test_no_token_uses_default_account(self) -> None:
        # Arrange
        registry = PerAccountStateRegistry(_SsmState)
        app, _ = create_ssm_app(registry=registry)
        ssm_client = TestClient(app, raise_server_exceptions=False)
        _ssm_post(ssm_client, "PutParameter", {"Name": "/my/param", "Value": "default-val"})

        # Act
        actual_status, actual_body = _ssm_post(ssm_client, "GetParameter", {"Name": "/my/param"})

        # Assert
        expected_status = 200
        assert actual_status == expected_status
        assert actual_body["Parameter"]["Value"] == "default-val"
