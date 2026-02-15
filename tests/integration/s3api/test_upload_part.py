"""Integration test for S3 UploadPart."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import httpx


class TestUploadPart:
    async def test_upload_part(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bucket = "test-bucket"
        expected_key = "test-key"
        expected_part_data = b"part-data"

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
        resp = await client.put(
            f"/{expected_bucket}/{expected_key}",
            params={"partNumber": "1", "uploadId": upload_id},
            content=expected_part_data,
        )

        # Assert
        assert resp.status_code == expected_status_code
