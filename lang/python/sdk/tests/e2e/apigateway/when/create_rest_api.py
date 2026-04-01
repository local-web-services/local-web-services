"""When: a REST API is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when("a REST API is created")
def create_rest_api(lws_session, world):
    try:
        world["result"] = ApigatewayTestClient(lws_session).create_rest_api()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
