"""When: all "dynamodb" "table"s are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('all "dynamodb" "table"s are listed')
def list_tables(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").list_tables()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
