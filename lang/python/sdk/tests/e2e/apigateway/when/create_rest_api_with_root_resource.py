"""When: a "REST" "API" is created with a root resource"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when('a "REST" "API" is created with a root resource')
def create_rest_api_with_root_resource(lws_session, world):
    try:
        world["result"] = ApigatewayTestClient(lws_session).create_rest_api()
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
