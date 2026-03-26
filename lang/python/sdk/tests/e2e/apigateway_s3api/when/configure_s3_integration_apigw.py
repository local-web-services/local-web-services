"""When: a direct S3 integration is configured on the "API" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayS3apiTestClient


@when('a direct S3 integration is configured on the "API"')
def configure_s3_integration_apigw(lws_session, world):
    try:
        api_id = ApigatewayS3apiTestClient(lws_session).get_api_id()
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        ApigatewayS3apiTestClient(lws_session).configure_s3_integration(api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
