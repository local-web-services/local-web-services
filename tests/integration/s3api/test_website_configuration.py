"""Integration tests for S3 bucket website configuration."""

from __future__ import annotations

import httpx

from lws.providers.s3.provider import S3Provider


class TestPutBucketWebsite:
    async def test_put_bucket_website(self, client: httpx.AsyncClient):
        # Arrange
        expected_status = 200
        xml_body = (
            "<WebsiteConfiguration>"
            "<IndexDocument><Suffix>index.html</Suffix></IndexDocument>"
            "<ErrorDocument><Key>error.html</Key></ErrorDocument>"
            "</WebsiteConfiguration>"
        )

        # Act
        resp = await client.put(
            "/test-bucket?website",
            content=xml_body.encode(),
        )

        # Assert
        assert resp.status_code == expected_status

    async def test_put_bucket_website_missing_index_returns_400(self, client: httpx.AsyncClient):
        # Arrange
        expected_status = 400
        xml_body = "<WebsiteConfiguration></WebsiteConfiguration>"

        # Act
        resp = await client.put(
            "/test-bucket?website",
            content=xml_body.encode(),
        )

        # Assert
        assert resp.status_code == expected_status
        assert b"InvalidArgument" in resp.content

    async def test_put_bucket_website_nonexistent_bucket(self, client: httpx.AsyncClient):
        # Arrange
        expected_status = 404
        xml_body = (
            "<WebsiteConfiguration>"
            "<IndexDocument><Suffix>index.html</Suffix></IndexDocument>"
            "</WebsiteConfiguration>"
        )

        # Act
        resp = await client.put(
            "/no-such-bucket?website",
            content=xml_body.encode(),
        )

        # Assert
        assert resp.status_code == expected_status


class TestGetBucketWebsite:
    async def test_get_bucket_website(self, client: httpx.AsyncClient, provider: S3Provider):
        # Arrange
        provider.put_bucket_website(
            "test-bucket",
            {"index_document": "index.html", "error_document": "error.html"},
        )
        expected_status = 200

        # Act
        resp = await client.get("/test-bucket?website")

        # Assert
        assert resp.status_code == expected_status
        assert b"<Suffix>index.html</Suffix>" in resp.content
        assert b"<Key>error.html</Key>" in resp.content

    async def test_get_bucket_website_not_configured(self, client: httpx.AsyncClient):
        # Arrange
        expected_status = 404

        # Act
        resp = await client.get("/test-bucket?website")

        # Assert
        assert resp.status_code == expected_status
        assert b"NoSuchWebsiteConfiguration" in resp.content


class TestDeleteBucketWebsite:
    async def test_delete_bucket_website(self, client: httpx.AsyncClient, provider: S3Provider):
        # Arrange
        provider.put_bucket_website("test-bucket", {"index_document": "index.html"})
        expected_status = 204

        # Act
        resp = await client.delete("/test-bucket?website")

        # Assert
        assert resp.status_code == expected_status

    async def test_delete_then_get_returns_not_configured(
        self, client: httpx.AsyncClient, provider: S3Provider
    ):
        # Arrange
        provider.put_bucket_website("test-bucket", {"index_document": "index.html"})
        await client.delete("/test-bucket?website")
        expected_status = 404

        # Act
        resp = await client.get("/test-bucket?website")

        # Assert
        assert resp.status_code == expected_status
        assert b"NoSuchWebsiteConfiguration" in resp.content


class TestWebsiteServing:
    async def test_index_document_served_for_trailing_slash(
        self, client: httpx.AsyncClient, provider: S3Provider
    ):
        # Arrange
        provider.put_bucket_website("test-bucket", {"index_document": "index.html"})
        await provider.put_object("test-bucket", "index.html", b"<html>home</html>")
        expected_body = b"<html>home</html>"

        # Act
        resp = await client.get("/test-bucket/")

        # Assert
        assert resp.status_code == 200
        actual_body = resp.content
        assert actual_body == expected_body

    async def test_error_document_served_with_404_status(
        self, client: httpx.AsyncClient, provider: S3Provider
    ):
        # Arrange
        provider.put_bucket_website(
            "test-bucket",
            {"index_document": "index.html", "error_document": "404.html"},
        )
        await provider.put_object("test-bucket", "404.html", b"<html>not found</html>")
        expected_status = 404
        expected_body = b"<html>not found</html>"

        # Act
        resp = await client.get("/test-bucket/missing.txt")

        # Assert
        assert resp.status_code == expected_status
        actual_body = resp.content
        assert actual_body == expected_body
