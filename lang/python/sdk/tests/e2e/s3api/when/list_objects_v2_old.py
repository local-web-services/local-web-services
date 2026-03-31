"""When: objects in a "s3" "bucket" are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET


@when('objects in a "s3" "bucket" are listed')
def list_objects_v2_old(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").list_objects_v2(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
