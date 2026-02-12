"""Integration tests for S3 Tables namespace operations."""

from __future__ import annotations

import httpx


class TestCreateNamespace:
    async def test_create_namespace(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "ns-int-bucket"
        namespace_name = "analytics"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_namespace = actual_body["namespace"]
        assert actual_namespace == [namespace_name]
        assert "tableBucketARN" in actual_body

    async def test_create_duplicate_namespace(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 409
        bucket_name = "dup-ns-int-bucket"
        namespace_name = "dup-analytics"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert
        assert resp.status_code == expected_status_code

    async def test_create_namespace_bucket_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        bucket_name = "ghost-ns-int-bucket"
        namespace_name = "orphan-ns"

        # Act
        resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert
        assert resp.status_code == expected_status_code


class TestListNamespaces:
    async def test_list_namespaces(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "list-ns-int-bucket"
        namespace_name = "listed-ns"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_namespaces = [ns["namespace"] for ns in actual_body["namespaces"]]
        assert [namespace_name] in actual_namespaces

    async def test_list_namespaces_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "empty-ns-int-bucket"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        assert actual_body["namespaces"] == []


class TestGetNamespace:
    async def test_get_namespace(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "get-ns-int-bucket"
        namespace_name = "get-ns"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_namespace = actual_body["namespace"]
        assert actual_namespace == [namespace_name]
        assert "createdAt" in actual_body

    async def test_get_namespace_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        bucket_name = "get-ns-miss-int-bucket"
        namespace_name = "missing-ns"
        await client.put("/table-buckets", json={"name": bucket_name})

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        assert resp.status_code == expected_status_code


class TestDeleteNamespace:
    async def test_delete_namespace(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        bucket_name = "del-ns-int-bucket"
        namespace_name = "del-ns"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Act
        resp = await client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Assert
        assert resp.status_code == expected_status_code

    async def test_delete_then_list_confirms_removal(self, client: httpx.AsyncClient):
        # Arrange
        bucket_name = "del-verify-ns-int-bucket"
        namespace_name = "del-verify-ns"
        await client.put("/table-buckets", json={"name": bucket_name})
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )
        await client.delete(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}")

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces")

        # Assert
        actual_body = resp.json()
        actual_namespaces = [ns["namespace"] for ns in actual_body["namespaces"]]
        assert [namespace_name] not in actual_namespaces
