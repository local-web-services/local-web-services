"""When: all REST APIs are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when("all REST APIs are listed")
def list_rest_apis(lws_session, world):
    try:
        world["result"] = lws_session.client("apigateway").get_rest_apis()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
