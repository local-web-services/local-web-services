"""Integration test for API Gateway V2 CreateIntegration."""

from __future__ import annotations

import httpx


class TestV2CreateIntegration:
    async def test_v2_create_integration(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        create_resp = await client.post(
            "/v2/apis",
            json={"Name": "int-v2-create-int", "ProtocolType": "HTTP"},
        )
        api_id = create_resp.json()["apiId"]

        # Act
        response = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={"IntegrationType": "AWS_PROXY"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "integrationId" in body
        expected_type = "AWS_PROXY"
        actual_type = body["integrationType"]
        assert actual_type == expected_type
