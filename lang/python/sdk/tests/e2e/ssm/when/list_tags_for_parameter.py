"""When: tags for a parameter are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM


@when("tags for a parameter are listed")
def list_tags_for_parameter(lws_session, world):
    try:
        desc = lws_session.client("ssm").describe_parameters(
            Filters=[{"Key": "Name", "Values": [TEST_PARAM]}]
        )
        if not desc.get("Parameters"):
            raise ClientError(
                {
                    "Error": {
                        "Code": "InvalidResourceId",
                        "Message": f"Parameter {TEST_PARAM} does not exist",
                    }
                },
                "ListTagsForResource",
            )
        resp = lws_session.client("ssm").list_tags_for_resource(
            ResourceType="Parameter", ResourceId=TEST_PARAM
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
