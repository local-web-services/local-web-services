"""Integration test for OpenSearch CreateDomain."""

from __future__ import annotations

import httpx


class TestCreateDomain:
    async def test_create_domain(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        domain_name = "int-os-domain"
        expected_domain_name = domain_name

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "OpenSearchService_20210101.CreateDomain"},
            json={"DomainName": domain_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_domain_name = body["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name
        assert "ARN" in body["DomainStatus"]
        assert "Endpoint" in body["DomainStatus"]

    async def test_create_duplicate_domain_returns_error(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ResourceAlreadyExistsException"
        domain_name = "int-os-dup-domain"

        await client.post(
            "/",
            headers={"X-Amz-Target": "OpenSearchService_20210101.CreateDomain"},
            json={"DomainName": domain_name},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "OpenSearchService_20210101.CreateDomain"},
            json={"DomainName": domain_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_create_then_describe(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        domain_name = "int-os-create-desc"
        expected_domain_name = domain_name

        await client.post(
            "/",
            headers={"X-Amz-Target": "OpenSearchService_20210101.CreateDomain"},
            json={"DomainName": domain_name},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "OpenSearchService_20210101.DescribeDomain"},
            json={"DomainName": domain_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_domain_name = body["DomainStatus"]["DomainName"]
        assert actual_domain_name == expected_domain_name
