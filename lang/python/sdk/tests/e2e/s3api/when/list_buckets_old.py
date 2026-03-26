"""When: all buckets are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when("all buckets are listed")
def list_buckets_old(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").list_buckets()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
