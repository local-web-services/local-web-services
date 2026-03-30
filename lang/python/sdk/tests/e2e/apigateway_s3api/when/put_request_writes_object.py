"""When: a "PUT" request is received and the "API" writes an object to the S3 bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayS3apiTestClient
from ..constants import TEST_BODY


@when('a "PUT" request is received and the "API" writes an object to the S3 bucket')
def put_request_writes_object(lws_session, world):
    try:
        api_id = world.get("api_id") or ApigatewayS3apiTestClient(lws_session).get_api_id()
        resp = ApigatewayS3apiTestClient(lws_session).invoke_api_put(api_id, TEST_BODY)
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
