"""When: all tables are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient


@when("all tables are listed")
def list_tables(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).list_tables()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
