"""When: the file is downloaded and decompressed"""

from __future__ import annotations

import gzip
import io
import json

from pytest_bdd import when

from ..constants import TEST_BUCKET


@when("the file is downloaded and decompressed")
def the_file_is_downloaded_and_decompressed(lws_session, world):
    s3 = lws_session.client("s3")
    try:
        resp = s3.list_objects_v2(Bucket=TEST_BUCKET)
        contents = resp.get("Contents", [])
        if contents:
            key = contents[0]["Key"]
            obj = s3.get_object(Bucket=TEST_BUCKET, Key=key)
            compressed = obj["Body"].read()
            with gzip.open(io.BytesIO(compressed)) as f:
                world["log_content"] = json.loads(f.read())
        else:
            world["log_content"] = None
        world["error"] = None
    except Exception as exc:
        world["log_content"] = None
        world["error"] = exc
