"""When: the "API" receives a request and enqueues it as an "SQS" message"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewaySqsTestClient


@when('the "API" receives a request and enqueues it as an "SQS" message')
def api_receives_request_enqueues(lws_session, world):
    try:
        api_id = world.get("api_id") or ApigatewaySqsTestClient(lws_session).get_api_id()
        resp = ApigatewaySqsTestClient(lws_session).invoke_api(
            api_id, {"event": "order-created", "orderId": "e2e-1"}
        )
        world["result"] = resp
        world["invoke_status"] = resp["status_code"]
        if resp["status_code"] != 200:
            world["error"] = Exception(
                f"API request failed with status {resp['status_code']}: {resp.get('body', '')}"
            )
        else:
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
