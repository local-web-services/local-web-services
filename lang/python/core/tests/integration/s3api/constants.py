"""Constants and shared helpers."""

from __future__ import annotations

import xml.etree.ElementTree as ET

INT_BUCKET = "int-test-bkt-1"

INT_SRC_BUCKET = "int-src-bkt-1"

INT_KEY = "int-test-key-1"

INT_KEY2 = "int-test-key-2"

INT_BODY = b"int-test-data-content-1"


def _parse_upload_id(response) -> str:
    root = ET.fromstring(response.text)
    ns = {"s3": "http://s3.amazonaws.com/doc/2006-03-01/"}
    upload_id = root.findtext("s3:UploadId", default="", namespaces=ns)
    if not upload_id:
        upload_id = root.findtext("UploadId", default="")
    return upload_id
