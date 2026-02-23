"""Integration test for Elasticsearch ListDomainNames."""

from __future__ import annotations

import httpx


class TestListDomainNames:
    async def test_list_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "ElasticsearchService_20150101.ListDomainNames"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DomainNames"]) == expected_count

    async def test_list_after_create(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        domain_name_a = "int-es-list-a"
        domain_name_b = "int-es-list-b"
        expected_count = 2

        await client.post(
            "/",
            headers={"X-Amz-Target": "ElasticsearchService_20150101.CreateElasticsearchDomain"},
            json={"DomainName": domain_name_a},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "ElasticsearchService_20150101.CreateElasticsearchDomain"},
            json={"DomainName": domain_name_b},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "ElasticsearchService_20150101.ListDomainNames"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["DomainNames"]) == expected_count
        names = [d["DomainName"] for d in body["DomainNames"]]
        assert domain_name_a in names
        assert domain_name_b in names
