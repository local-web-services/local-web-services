"""Integration test for S3 AbortMultipartUpload."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import httpx


class TestAbortMultipartUpload:
    async def test_abort_multipart_upload(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 204
        expected_bucket = "test-bucket"
        expected_key = "test-key"

        create_resp = await client.post(
            f"/{expected_bucket}/{expected_key}",
            params={"uploads": ""},
        )
        root = ET.fromstring(create_resp.text)
        ns = {"s3": "http://s3.amazonaws.com/doc/2006-03-01/"}
        upload_id = root.findtext("s3:UploadId", default="", namespaces=ns)
        if not upload_id:
            upload_id = root.findtext("UploadId", default="")

        # Act
        resp = await client.delete(
            f"/{expected_bucket}/{expected_key}",
            params={"uploadId": upload_id},
        )

        # Assert
        assert resp.status_code == expected_status_code
