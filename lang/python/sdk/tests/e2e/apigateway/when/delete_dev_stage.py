"""When: the dev stage is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_STAGE_DEV


@when("the dev stage is deleted")
def delete_dev_stage(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        world["result"] = ApigatewayTestClient(lws_session).delete_stage(
            restApiId=api_id, stageName=TEST_STAGE_DEV
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
