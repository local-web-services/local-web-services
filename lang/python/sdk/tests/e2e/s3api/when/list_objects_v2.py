"""When: objects in a bucket are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@when("objects in a bucket are listed")
def list_objects_v2(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
