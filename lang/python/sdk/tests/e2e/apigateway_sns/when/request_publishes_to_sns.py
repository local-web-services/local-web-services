"""When: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewaySnsTestClient
from ..constants import _topic_arn


@when(
    'a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200'
)
def request_publishes_to_sns(lws_session, world):
    try:
        api_id = world.get("api_id") or ApigatewaySnsTestClient(lws_session).get_api_id()
        resp = ApigatewaySnsTestClient(lws_session).invoke_api(
            api_id, {"TopicArn": _topic_arn(), "Message": "e2e-test-message"}
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
