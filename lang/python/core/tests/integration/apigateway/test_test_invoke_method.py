"""Integration test for API Gateway REST API method creation and retrieval.

The AWS TestInvokeMethod API is not implemented in lws.  This test
exercises the closest available operations: creating a REST API,
adding a resource, putting a method on it, and retrieving that method.
"""

from __future__ import annotations

import httpx


class TestTestInvokeMethod:
    async def test_create_rest_api_and_put_method(self, client: httpx.AsyncClient):
        # Arrange
        expected_api_name = "test-api"
        expected_create_status = 201
        expected_method_status = 201
        expected_http_method = "GET"

        # Act — create REST API
        create_resp = await client.post(
            "/restapis",
            json={"name": expected_api_name},
        )

        # Assert — REST API created
        assert create_resp.status_code == expected_create_status
        api_body = create_resp.json()
        actual_api_id = api_body["id"]
        actual_root_resource_id = api_body["rootResourceId"]
        assert api_body["name"] == expected_api_name

        # Act — create child resource
        resource_resp = await client.post(
            f"/restapis/{actual_api_id}/resources/{actual_root_resource_id}",
            json={"pathPart": "items"},
        )

        # Assert — resource created
        assert resource_resp.status_code == expected_create_status
        resource_body = resource_resp.json()
        actual_resource_id = resource_body["id"]
        assert resource_body["path"] == "/items"

        # Act — put method on resource
        method_resp = await client.put(
            f"/restapis/{actual_api_id}/resources/{actual_resource_id}/methods/{expected_http_method}",
            json={"authorizationType": "NONE"},
        )

        # Assert — method created
        assert method_resp.status_code == expected_method_status
        method_body = method_resp.json()
        assert method_body["httpMethod"] == expected_http_method
        assert method_body["authorizationType"] == "NONE"

        # Act — retrieve method
        get_method_resp = await client.get(
            f"/restapis/{actual_api_id}/resources/{actual_resource_id}/methods/{expected_http_method}",
        )

        # Assert — method retrieved
        expected_get_status = 200
        assert get_method_resp.status_code == expected_get_status
        get_body = get_method_resp.json()
        assert get_body["httpMethod"] == expected_http_method
