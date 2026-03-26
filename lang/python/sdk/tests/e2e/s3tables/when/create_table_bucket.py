"""When: a table bucket is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET


@when("a table bucket is created")
def create_table_bucket(lws_session, world):
    try:
        world["result"] = lws_session.client("s3tables").create_table_bucket(name=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
