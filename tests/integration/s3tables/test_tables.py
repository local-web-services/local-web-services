"""Integration tests for S3 Tables table operations (full lifecycle)."""

from __future__ import annotations

import httpx


async def _setup_bucket_and_namespace(
    client: httpx.AsyncClient, bucket_name: str, namespace_name: str
) -> None:
    """Helper to create a table bucket and namespace for table tests."""
    await client.put("/table-buckets", json={"name": bucket_name})
    await client.put(
        f"/table-buckets/{bucket_name}/namespaces",
        json={"namespace": [namespace_name]},
    )


class TestCreateTable:
    async def test_create_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "tbl-int-bucket"
        namespace_name = "tbl-int-ns"
        table_name = "events"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)

        # Act
        resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        assert "tableARN" in actual_body
        assert table_name in actual_body["tableARN"]

    async def test_create_duplicate_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 409
        bucket_name = "dup-tbl-int-bucket"
        namespace_name = "dup-tbl-int-ns"
        table_name = "dup-events"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Assert
        assert resp.status_code == expected_status_code


class TestListTables:
    async def test_list_tables(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "list-tbl-int-bucket"
        namespace_name = "list-tbl-int-ns"
        table_name = "listed-events"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_names = [t["name"] for t in actual_body["tables"]]
        assert table_name in actual_names

    async def test_list_tables_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "empty-tbl-int-bucket"
        namespace_name = "empty-tbl-int-ns"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        assert actual_body["tables"] == []


class TestGetTable:
    async def test_get_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        bucket_name = "get-tbl-int-bucket"
        namespace_name = "get-tbl-int-ns"
        table_name = "get-events"
        expected_format = "ICEBERG"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": expected_format},
        )

        # Act
        resp = await client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_body = resp.json()
        actual_name = actual_body["name"]
        assert actual_name == table_name
        actual_format = actual_body["format"]
        assert actual_format == expected_format
        assert "tableARN" in actual_body
        assert "createdAt" in actual_body

    async def test_get_table_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        bucket_name = "get-tbl-miss-int-bucket"
        namespace_name = "get-tbl-miss-int-ns"
        table_name = "missing-table"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)

        # Act
        resp = await client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        assert resp.status_code == expected_status_code


class TestDeleteTable:
    async def test_delete_table(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        bucket_name = "del-tbl-int-bucket"
        namespace_name = "del-tbl-int-ns"
        table_name = "del-events"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )

        # Act
        resp = await client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert
        assert resp.status_code == expected_status_code

    async def test_delete_then_list_confirms_removal(self, client: httpx.AsyncClient):
        # Arrange
        bucket_name = "del-verify-tbl-int-bucket"
        namespace_name = "del-verify-tbl-int-ns"
        table_name = "del-verify-events"
        await _setup_bucket_and_namespace(client, bucket_name, namespace_name)
        await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": "ICEBERG"},
        )
        await client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Act
        resp = await client.get(f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables")

        # Assert
        actual_body = resp.json()
        actual_names = [t["name"] for t in actual_body["tables"]]
        assert table_name not in actual_names


class TestFullLifecycle:
    async def test_create_bucket_namespace_table_then_cleanup(self, client: httpx.AsyncClient):
        # Arrange
        bucket_name = "lifecycle-bucket"
        namespace_name = "lifecycle-ns"
        table_name = "lifecycle-table"
        expected_format = "ICEBERG"

        # Act — create bucket
        bucket_resp = await client.put("/table-buckets", json={"name": bucket_name})

        # Assert — bucket created
        expected_bucket_status = 200
        assert bucket_resp.status_code == expected_bucket_status

        # Act — create namespace
        ns_resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces",
            json={"namespace": [namespace_name]},
        )

        # Assert — namespace created
        expected_ns_status = 200
        assert ns_resp.status_code == expected_ns_status

        # Act — create table
        table_resp = await client.put(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables",
            json={"name": table_name, "format": expected_format},
        )

        # Assert — table created
        expected_table_status = 200
        assert table_resp.status_code == expected_table_status

        # Act — get table details
        get_resp = await client.get(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert — table details correct
        actual_body = get_resp.json()
        actual_name = actual_body["name"]
        assert actual_name == table_name
        actual_format = actual_body["format"]
        assert actual_format == expected_format

        # Act — delete table
        del_table_resp = await client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}/tables/{table_name}"
        )

        # Assert — table deleted
        expected_del_status = 204
        assert del_table_resp.status_code == expected_del_status

        # Act — delete namespace
        del_ns_resp = await client.delete(
            f"/table-buckets/{bucket_name}/namespaces/{namespace_name}"
        )

        # Assert — namespace deleted
        assert del_ns_resp.status_code == expected_del_status

        # Act — delete bucket
        del_bucket_resp = await client.delete(f"/table-buckets/{bucket_name}")

        # Assert — bucket deleted
        assert del_bucket_resp.status_code == expected_del_status

        # Act — confirm bucket is gone
        list_resp = await client.get("/table-buckets")

        # Assert — bucket list is empty
        actual_body = list_resp.json()
        actual_names = [b["name"] for b in actual_body["tableBuckets"]]
        assert bucket_name not in actual_names
