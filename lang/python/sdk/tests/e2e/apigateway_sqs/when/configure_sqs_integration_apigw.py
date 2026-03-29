"""When: an "SQS" direct integration is configured on the "REST" "API" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewaySqsTestClient


@when('an "SQS" direct integration is configured on the "REST" "API"')
def configure_sqs_integration_apigw(lws_session, world):
    try:
        api_id = ApigatewaySqsTestClient(lws_session).get_api_id()
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        ApigatewaySqsTestClient(lws_session).configure_sqs_integration(api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
