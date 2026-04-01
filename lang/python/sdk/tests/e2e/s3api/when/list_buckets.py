"""When: the list of "s3" "buckets" is retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('the list of "s3" "buckets" is retrieved')
def list_buckets(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").list_buckets()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
