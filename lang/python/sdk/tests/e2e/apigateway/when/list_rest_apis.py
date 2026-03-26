"""When: all REST APIs are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when("all REST APIs are listed")
def list_rest_apis(lws_session, world):
    try:
        world["result"] = ApigatewayTestClient(lws_session).get_rest_apis()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
