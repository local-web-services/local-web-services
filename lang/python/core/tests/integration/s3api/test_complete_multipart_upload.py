"""Integration test for S3 CompleteMultipartUpload."""

from __future__ import annotations

import xml.etree.ElementTree as ET

import httpx


class TestCompleteMultipartUpload:
    async def test_complete_multipart_upload(self, client: httpx.AsyncClient):
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

        part_resp = await client.put(
            f"/{expected_bucket}/{expected_key}",
            params={"partNumber": "1", "uploadId": upload_id},
            content=expected_part_data,
        )
        etag = part_resp.headers.get("ETag", "")

        complete_body = (
            "<CompleteMultipartUpload>"
            "<Part>"
            "<PartNumber>1</PartNumber>"
            f"<ETag>{etag}</ETag>"
            "</Part>"
            "</CompleteMultipartUpload>"
        )

        # Act
        resp = await client.post(
            f"/{expected_bucket}/{expected_key}",
            params={"uploadId": upload_id},
            content=complete_body.encode(),
            headers={"Content-Type": "application/xml"},
        )

        # Assert
        assert resp.status_code == expected_status_code
