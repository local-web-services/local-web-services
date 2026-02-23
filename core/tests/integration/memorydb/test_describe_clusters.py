"""Integration test for MemoryDB DescribeClusters."""

from __future__ import annotations

import httpx


class TestDescribeClusters:
    async def test_describe_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 0

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.DescribeClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_count = len(body["Clusters"])
        assert actual_count == expected_count

    async def test_describe_after_create(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_count = 2
        cluster_a = "int-desc-a"
        cluster_b = "int-desc-b"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_a},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_b},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.DescribeClusters"},
            json={},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_count = len(body["Clusters"])
        assert actual_count == expected_count
        actual_names = [c["Name"] for c in body["Clusters"]]
        assert cluster_a in actual_names
        assert cluster_b in actual_names

    async def test_describe_by_name(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        cluster_name = "int-desc-specific"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.CreateCluster"},
            json={"ClusterName": cluster_name},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.DescribeClusters"},
            json={"ClusterName": cluster_name},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert len(body["Clusters"]) == 1
        actual_name = body["Clusters"][0]["Name"]
        assert actual_name == cluster_name

    async def test_describe_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 400
        expected_error_type = "ClusterNotFoundFault"

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonMemoryDB.DescribeClusters"},
            json={"ClusterName": "nonexistent"},
        )

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
