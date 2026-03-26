"""When: a "REST" "API" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_API


@when('a "REST" "API" is created')
def create_rest_api_cognito(lws_session, world):
    try:
        resp = lws_session.client("apigateway").create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
