"""Integration test for API Gateway V2 DeleteIntegration."""

from __future__ import annotations

import httpx


class TestV2DeleteIntegration:
    async def test_v2_delete_integration(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-del-int", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={"IntegrationType": "AWS_PROXY"},
        )
        integration_id = int_resp.json()["integrationId"]

        # Act
        response = await client.delete(f"/v2/apis/{api_id}/integrations/{integration_id}")

        # Assert
        assert response.status_code == expected_status_code
