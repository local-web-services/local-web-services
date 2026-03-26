"""When: the list of buckets is retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient


@when("the list of buckets is retrieved")
def list_buckets(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).list_buckets()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
