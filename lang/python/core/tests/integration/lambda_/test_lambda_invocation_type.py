"""Integration tests for X-Amz-Invocation-Type header handling in Lambda routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app

_INT_FUNCTION_NAME = "int-async-lambda-fn-1"
_INT_ROLE_ARN = "arn:aws:iam::000000000000:role/int-test-role-1"


@pytest.fixture
def app():
    # Arrange
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


async def _create_function(client: httpx.AsyncClient) -> None:
    await client.post(
        "/2015-03-31/functions",
        json={
            "FunctionName": _INT_FUNCTION_NAME,
            "Runtime": "python3.12",
            "Role": _INT_ROLE_ARN,
            "Handler": "index.handler",
            "Code": {"ZipFile": ""},
        },
    )


class TestLambdaInvocationType:
    """Test that the X-Amz-Invocation-Type header is respected."""

    async def test_event_invocation_type_returns_202(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_function(client)
        expected_status_code = 202

        # Act
        actual_response = await client.post(
            f"/2015-03-31/functions/{_INT_FUNCTION_NAME}/invocations",
            headers={"X-Amz-Invocation-Type": "Event"},
            json={},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for Event invocation "
            f"but got {actual_status_code}"
        )

    async def test_event_invocation_type_returns_request_id_header(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        await _create_function(client)
        expected_header = "x-amzn-requestid"

        # Act
        actual_response = await client.post(
            f"/2015-03-31/functions/{_INT_FUNCTION_NAME}/invocations",
            headers={"X-Amz-Invocation-Type": "Event"},
            json={},
        )

        # Assert
        actual_headers = {k.lower(): v for k, v in actual_response.headers.items()}
        assert expected_header in actual_headers, (
            f"Expected '{expected_header}' header in response but headers were: "
            f"{list(actual_headers.keys())}"
        )

    async def test_request_response_invocation_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_function(client)
        expected_status_code = 200

        # Act
        actual_response = await client.post(
            f"/2015-03-31/functions/{_INT_FUNCTION_NAME}/invocations",
            headers={"X-Amz-Invocation-Type": "RequestResponse"},
            json={},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for RequestResponse invocation "
            f"but got {actual_status_code}"
        )

    async def test_default_invocation_without_header_returns_200(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        await _create_function(client)
        expected_status_code = 200

        # Act
        actual_response = await client.post(
            f"/2015-03-31/functions/{_INT_FUNCTION_NAME}/invocations",
            json={},
        )

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for invocation without header "
            f"but got {actual_status_code}"
        )

    async def test_event_invocation_type_request_id_is_queryable(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        await _create_function(client)
        expected_state = "IN_PROGRESS"

        # Act
        invoke_response = await client.post(
            f"/2015-03-31/functions/{_INT_FUNCTION_NAME}/invocations",
            headers={"X-Amz-Invocation-Type": "Event"},
            json={},
        )
        invocation_id = invoke_response.headers.get("x-amzn-requestid", "")
        state_response = await client.get(f"/lws/invocations/{invocation_id}")

        # Assert
        actual_state = state_response.json().get("State", "")
        assert actual_state in (expected_state, "SUCCESS", "FAILED"), (
            f"Expected invocation state to be one of "
            f"('{expected_state}', 'SUCCESS', 'FAILED') "
            f"but got '{actual_state}'"
        )

    async def test_get_invocation_state_returns_404_for_unknown_id(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        expected_status_code = 404
        unknown_invocation_id = "00000000-0000-0000-0000-000000000000"

        # Act
        actual_response = await client.get(f"/lws/invocations/{unknown_invocation_id}")

        # Assert
        actual_status_code = actual_response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected status {expected_status_code} for unknown invocation "
            f"but got {actual_status_code}"
        )
